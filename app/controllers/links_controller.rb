class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: [:send_to_url, :verificar_password]
  before_action :authorize_user, only: [:edit, :update]

  def index
    @links = current_user.links.paginate(page: params[:page], per_page: 4)
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      redirect_to links_path, notice: 'Link actualizado con exito'
    else
      render :edit
    end
  end

  def new
    @link = current_user.links.build
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      @link.update(short_url: "l/#{encode_id(@link.id)}")
      redirect_to links_path, notice: 'Link creado con éxito'
    else
      flash[:error] = @link.errors.full_messages.to_sentence
      render :new
    end
  end

  def send_to_url
    if @link.type == "PrivateLink"
      render "password_form"
      return
    end
    result = @link.redirect(@link)
    if result[:success]
      create_statistics(@link, request.remote_ip)
      redirect_to @link.url, allow_other_host: true
    else
      render :file => "#{Rails.root}/public/#{result[:status]}.html"
    end
  end

  def verificar_password
    entered_password = params[:password]
    result = @link.redirect(entered_password)
    if result[:success]
      create_statistics(@link, request.remote_ip)
      redirect_to @link.url, allow_other_host: true
    else
      flash[:error] = result[:message]
      redirect_to action: 'send_to_url'
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy!
    redirect_to links_path, notice: 'Link eliminado con exito'
  end

  private

  def create_statistics(link, ip)
    LinkStatistic.increment_count(link)
    LinkAccessDetail.add_access(link, ip)
  end

  def link_params
    params.require(:link).permit(:url, :type, :nombre, :expiration_date).tap do |whitelisted|
      whitelisted[:password] = params[:link][:password] if params[:link][:type] == 'PrivateLink'
      whitelisted[:entered] = params[:link][:entered] if params[:link][:type] == 'EphemeralLink'
      whitelisted[:expiration_date] = params[:link][:expiration_date] if params[:link][:type] == 'TemporalLink'
    end
  end

  def set_link
    id = decode_id(params[:short_url])
    @link = Link.find(id)
  end

  def encode_id(id)
    Base64.urlsafe_encode64(id.to_s)
  end

  def decode_id(encoded_id)
    Base64.urlsafe_decode64(encoded_id).to_i
  end
end

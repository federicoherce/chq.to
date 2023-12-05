class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: [:send_to_url, :verificar_password]
  before_action :authorize_user, only: [:edit, :update]

  def index
    @links = current_user.links
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
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    if @link.save
      @link.update(short_url: "l/#{encode_id(@link.id)}")
      redirect_to links_path, notice: 'Link creado con exito'
    else
      flash[:error] = @link.errors.full_messages.to_sentence
      redirect_to action: 'new'
    end
  end

  def send_to_url
    if @link.type == "PrivateLink"
      render "password_form"
      return
    end
    result = @link.redirect(@link)
    if result[:success]
      LinkStatistic.increment_count(@link)
      LinkAccessDetail.add_access(@link, request.remote_ip)
      redirect_to @link.url, allow_other_host: true
    else
      render :file => "#{Rails.root}/public/#{result[:status]}.html"
    end
  end

  def verificar_password
    entered_password = params[:password]
    result = @link.redirect(entered_password)
    if result[:success]
      LinkStatistic.increment_count(@link)
      LinkAccessDetail.add_access(@link, request.remote_ip)
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

  def authorize_user
    @link = Link.find(params[:id])
    unless current_user == @link.user
      redirect_to links_path, alert: "Acceso denegado"
    end
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

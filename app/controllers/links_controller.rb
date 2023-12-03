class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: [:send_to_url, :verificar_password]

  def index
    @links = current_user.links
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      redirect_to links_path, notice: 'Link was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @link = current_user.links.build # preparando una nueva instancia de Link que ya está asociada al usuario actual.
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    if @link.save
      @link.update(short_url: "l/#{encode_id(@link.id)}")
      redirect_to links_path, notice: 'Link was successfully created.'
      #redirect_to action: 'index', parametro: "hola", notice: 'Link was successfully updated.'
      #redirect_to controller: 'otro_controlador', action: 'otra_accion'
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
      redirect_to @link.url, allow_other_host: true
    else
      render :file => "#{Rails.root}/public/#{result[:status]}.html"
    end
  end

  def verificar_password
    entered_password = params[:password]
    result = @link.redirect(entered_password)
    if result[:success]
      redirect_to @link.url, allow_other_host: true
    else
      flash[:error] = result[:message]
      redirect_to action: 'send_to_url'
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy!
    redirect_to links_path, notice: 'Link was successfully deleted'
  end

  private

  def link_params
    #params.require(:link).permit(:url, :type, :nombre, :expiration_date, :password, :entered)
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

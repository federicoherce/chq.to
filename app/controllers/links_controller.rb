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
      #redirect_to action: 'index', parametro: "hola", notice: 'Link was successfully updated.'
      #redirect_to controller: 'otro_controlador', action: 'otra_accion'
    else
      render :edit
    end
  end

  def new
    @link = current_user.links.build # preparando una nueva instancia de Link que ya está asociada al usuario actual.
  end

  def create
    #@link = Link.new(link_params)
    #@link.user_id = current_user.id
    #@link = Link.build(link_params[:url], link_params[:tipo], current_user.id)
    case link_params[:tipo]
    when 'private'
      @link = PrivateLink.new(link_params)
    when 'temporal'
      @link = TemporalLink.new(link_params)
    else
      @link = Link.new(link_params)
    end
    @link.user_id = current_user.id
    if @link.save
      @link.update(short_url: "http://127.0.0.1:3000/#{encode_id(@link.id)}")
      redirect_to links_path, notice: 'Link was successfully created.'
    else
      flash[:error] = @link.errors.full_messages.to_sentence
      redirect_to action: 'new'
    end
  end

  def send_to_url
    if @link.tipo == "private"
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

  def set_link
    id = decode_id(params[:short_url])
    @link = Link.find(id)
    link_class = @link.tipo.capitalize + 'Link'
    @link = @link.becomes(link_class.constantize)
  end

  def link_params
    params.require(:link).permit(:url, :tipo, :nombre, :expiration_date).tap do |whitelisted|
      whitelisted[:password] = params[:link][:password] if params[:link][:tipo] == 'private'
      whitelisted[:entered] = params[:link][:entered] if params[:link][:tipo] == 'ephemeral'
    end
  end

  def encode_id(id)
    Base64.urlsafe_encode64(id.to_s)
  end

  def decode_id(encoded_id)
    Base64.urlsafe_decode64(encoded_id).to_i
  end
end



#Edicion de links. Url, tipo
#Link seguros? slug/patron
#La clave solo la ingresan los visitantes?

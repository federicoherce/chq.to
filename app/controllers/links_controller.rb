class LinksController < ApplicationController
  before_action :authenticate_user!


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
    @link = current_user.links.build
  end

  def create
    @link = current_user.links.build(link_params)
    case @link.tipo_link
    when 'regular'
      @link.linkable = RegularLink.new
    when 'temporal'
      @link.linkable = TemporalLink.new
    when 'privado'
      @link.linkable = PrivateLink.new
    when 'efimero'
      @link.linkable = EphemeralLink.new
    end
    if @link.save
      @link.update(short_url: "http://127.0.0.1:3000/#{encode_id(@link.id)}")
      redirect_to links_path, notice: 'Link was successfully created.'
    else
      puts @link.errors.full_messages
      render :new
    end
  end

  def send_to_url
    id = decode_id(params{:short_url})
    link = Link.find(id)
    redirect_to link.url, allow_other_host: true
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy!
    redirect_to links_path, notice: 'Link was successfully deleted'
  end


  private

  def link_params
    params.require(:link).permit(:url, :tipo_link, :expiration_date, :password, :entered)
  end


  def encode_id(id)
    Base64.urlsafe_encode64(id.to_s)
  end


  def decode_id(encoded_id)
    Base64.urlsafe_decode64(encoded_id[:short_url]).to_i
  end
end

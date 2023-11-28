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
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    if @link.save
      @link.update(short_url: "http://127.0.0.1:3000/#{encode_id(@link.id)}")
      redirect_to links_path, notice: 'Link was successfully created.'
    else
      p @link.errors.full_messages
      render :new
    end
  end

  def send_to_url
    id = decode_id(params{:short_url})
    link = Link.find(id)
    link_class = link.tipo.capitalize + 'Link'
    link = link.becomes(link_class.constantize)

    if link.redirect(link)
      redirect_to link.url, allow_other_host: true
    else
      p "no se pudo"
    end
     #link = Link.find_subclass(id)
  end


  def destroy
    @link = Link.find(params[:id])
    @link.destroy!
    redirect_to links_path, notice: 'Link was successfully deleted'
  end


  private

  def link_params
    params.require(:link).permit(:url, :tipo, :expiration_date)
  end


  def encode_id(id)
    Base64.urlsafe_encode64(id.to_s)
  end


  def decode_id(encoded_id)
    Base64.urlsafe_decode64(encoded_id[:short_url]).to_i
  end
end

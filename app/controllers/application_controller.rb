class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def authorize_user
    @link = Link.find(params[:id])
    unless current_user == @link.user
      redirect_to links_path, alert: "Acceso denegado"
    end
  end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end

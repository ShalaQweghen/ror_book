class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def posting
  	if params[:commentable_type] == "Picture"
  		"picture"
  	else
  		"post"
  	end
  end

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :picture])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:username, :picture])
  end
end

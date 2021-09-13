class ApplicationController < ActionController::Base
  before_action :configure_permmited_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    comments_path
  end

  private

  def configure_permmited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:email, :gender])
  end
end

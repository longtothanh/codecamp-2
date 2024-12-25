class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :type ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :type ])
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    elsif resource.user?
      user_root_path
    else
      root_path
    end
  end
end

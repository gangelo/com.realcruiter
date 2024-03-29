class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # TODO: Implement this when referral_code is added to the User model.
    # devise_parameter_sanitizer.for(:sign_up) << :referral_code
  end

  def after_sign_in_path_for(resource)
    dashboards_path
  end

end

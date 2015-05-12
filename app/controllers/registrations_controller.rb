require 'profile_creator'

class RegistrationsController < Devise::RegistrationsController
 
  def create
    super {|resource| 
      if resource.persisted? 
        begin
          interactor = ProfileCreator.new({type: profile_type_params, profile_name: 'My Profile'}, resource)
  		    interactor.execute
        rescue => error
          logger.info '*** error encountered: ' + error.message + ' ***'
          raise ArgumentError, "Unable to create user profile: [#{profile_type_params}]"
        end
      end
    }
  end

  def profile_type_params
    params.require(:profile_type)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password) }
  end
end 
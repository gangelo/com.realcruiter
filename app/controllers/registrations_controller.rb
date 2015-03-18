require 'profile_creator'

class RegistrationsController < Devise::RegistrationsController
 
  def create
    super {|resource| 
      if resource.persisted? 
        #resource.add_profile params[:profile_type].to_sym

        begin
          interactor = ProfileCreator.new(profile_type_params, resource)
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

end 
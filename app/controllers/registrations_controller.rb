require 'profile_creator'

class RegistrationsController < Devise::RegistrationsController
 
  def create
    super {|resource| 
      if resource.persisted? 
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
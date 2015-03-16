class RegistrationsController < Devise::RegistrationsController
 
  def create
    super {|resource| 
      if resource.persisted? 
        resource.add_profile params[:profile_type].to_sym
      end
    }
  end

end 
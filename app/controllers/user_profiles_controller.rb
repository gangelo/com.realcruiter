class UserProfilesController < ApplicationController
	def new
		@user_profile = UserProfile.new
	end

  def create
  	@user_profile = UserProfile.new(user_profile_params)
  	if @user_profile.invalid?
  		render :new
  	else
	  	@user_profile = current_user.add_profile(user_profile_params[:profile_type].to_sym, user_profile_params)
	  	if @user_profile.errors.any?
		  	render :new
		  else
		  	# TODO: Redirect somewhere with alert.
		  	render :new
		  end
		end
  end

  def user_profile_params
    params.require(:user_profile).permit(:profile_name, :profile_type)
  end
end

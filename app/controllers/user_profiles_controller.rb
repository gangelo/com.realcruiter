class UserProfilesController < ApplicationController
	before_action :authenticate_user!

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
		  	redirect_to(dashboards_url, notice: 'Your new profile has been created!') and return
		  end
		end
  end

  def skills
    @skills = Skill.order(:name).where("name ILIKE ?", "#{skills_search_params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @skills.map(&:name)
      }
    end
  end

  private

  def user_profile_params
    params.require(:user_profile).permit(:profile_name, :profile_type, skills_attributes: [:id, :name])
  end

  def skills_search_params
    params.permit(:term)
  end
end

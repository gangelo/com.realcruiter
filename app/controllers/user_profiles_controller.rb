require 'profile_creator'

class UserProfilesController < ApplicationController
	before_action :authenticate_user!

  def index
    @user_profiles = UserProfile.where(user_id: current_user.id).order(:profile_name)
  end

	def new
    @user_profile = UserProfile.new({profile_type: :user_profile})
	end

  def create
    interactor = ProfileCreator.new(user_profile_params, current_user)
    if interactor.execute
      redirect_to(dashboards_url, notice: 'Your new profile has been created!') and return
    else
      @user_profile = interactor.profile
      render :new
    end
  end

  def destroy
    current_user.user_profiles.find(params[:profile_id]).delete
    redirect_to profiles_url, notice: 'Profile deleted'
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
    profile_type = :user_profile if params.has_key? :user_profile
    profile_type = :technical_recruiter_profile if params.has_key? :technical_recruiter_profile
    profile_type = :software_developer_profile if params.has_key? :software_developer_profile
    params.require(profile_type).permit(:profile_name, :profile_type, skills_attributes: [:id, :name])
  end

  def skills_search_params
    params.permit(:term)
  end
end

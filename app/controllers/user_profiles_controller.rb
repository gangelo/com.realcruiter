require 'profile_creator'

class UserProfilesController < ApplicationController
	before_action :authenticate_user!

  def index
    @user_profiles = UserProfile.where(user_id: current_user.id).order(:profile_name)
  end

  def new
    @user_profile = UserProfile.new({profile_type: UserProfile.name.underscore})
    render layout: 'new_profile'
  end

  def create
    interactor = ProfileCreator.new(create_params, current_user)
    if interactor.execute
      redirect_to(dashboards_url, notice: 'Your new profile has been created!')
    else
      @user_profile = interactor.profile
      render :new, layout: 'new_profile'
    end
  end

  def edit
    @user_profile = current_user.user_profiles.find(params[:id])
    render layout: 'edit_profile'
  end

  def update
    @user_profile = UserProfile.find_by_id(params[:id])
    if @user_profile.update(update_params.merge(user: current_user))
      redirect_to(dashboards_url, notice: 'Your profile has been saved!')
    else
      flash[:alert] = 'Unable to update profile'
      render :edit, layout: 'edit_profile'
    end
  end

  def destroy
    begin
      UserProfile.find(destroy_params).destroy
      redirect_to profiles_url, notice: 'Profile deleted'
    rescue ActiveRecord::RecordNotFound
      alert = 'That profile no longer exists'
    rescue
      alert = "That profile couldn't be deleted for some reason. Give it another try later."
    end
    redirect_to(profiles_url, alert: alert)
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

  def create_params
    profile_type = if params.has_key? :user_profile
      :user_profile
    elsif params.has_key? :technical_recruiter_profile
      :technical_recruiter_profile
    elsif params.has_key? :software_developer_profile
      :software_developer_profile
    end
    params.require(profile_type).permit(:profile_name, :profile_type, all_skills_attributes: [:id, :name])
  end

  def update_params
    profile_type = if params.has_key? :technical_recruiter_profile
      :technical_recruiter_profile
    elsif params.has_key? :software_developer_profile
      :software_developer_profile
    end
   
    params[profile_type][:all_skills_attributes] ||= {} 
    params.require(profile_type).permit(:profile_name, :type, all_skills_attributes: [:id, :name])
  end

  def destroy_params
    params.require(:profile_id)
  end

  def skills_search_params
    params.permit(:term)
  end
end

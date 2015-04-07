class SearchController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @search_criteria = SearchCriteria.new
  end

  def search
    paginate_params = {page: params[:page].presence || 1, per_page: params[:per_page]}
    @search_criteria = SearchCriteria.new(search_params.merge(paginate_params))
    @search_criteria.valid?
    render :index
  end

  def skills
    @skills = Skill.order(:name).where("name ILIKE ?", "#{skills_search_params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @skills.pluck(:name)
      }
    end
  end

  private

  def search_params
    params[:search_criteria][:search_skills_attributes] ||= {}
    params.require(:search_criteria).permit(:search_string, search_skills_attributes: [:id, :skill_name, :skill_valid])
  end

  def skills_search_params
    params.permit(:term)
  end
end

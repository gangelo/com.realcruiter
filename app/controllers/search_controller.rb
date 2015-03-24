class SearchController < ApplicationController
  def index
    @search_criteria = SearchCriteria.new
  end

  def search
    @search_criteria = SearchCriteria.new(search_params)
    @search_criteria.valid?
    render :index
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

  def search_params
    params.require(:search_criteria).permit(:search_string)
  end

  def skills_search_params
    params.permit(:term)
  end
end

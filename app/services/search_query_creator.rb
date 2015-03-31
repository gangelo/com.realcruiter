class SearchQueryCreator
  def initialize(search_skills, current_user, options={})
    @search_skills = search_skills
    @current_user = current_user
    @options = options
  end

  def execute
    build_query_string
  end

  private

  def build_query_string
  end

  def extract_valid_search_skills
    @search_skills.select{ |skill| skill.skill_valid }
  end
end
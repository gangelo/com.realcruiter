require 'skill'
require 'search_skill'
require 'skills_search_string'

class SearchSkillsCreator
  include Skills::SearchString

  def initialize(search_string)
    @search_string = search_string
  end

  def execute(&block)
    skills = []
    
    tokenize_search_string(@search_string).each do |name|
      search_skill = create_skill(name)
      yield search_skill if block_given?
      skills << search_skill
    end

    skills
  end

  private

  def create_skill(skill_name) 
    search_skill = validate_skill(SearchSkill.new(skill_name: skill_name))
  end

  def validate_skill(search_skill)
    search_skill.skill_valid = Skill.exists?(['name ILIKE ?', search_skill.skill_name]) 
    search_skill
  end
end
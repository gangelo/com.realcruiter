require 'skill'
require 'search_skill'
require 'skills_search_string'

class SearchSkillsCreator
  include Skills::SearchString

  def initialize(param)
    @search_string = nil
    @user_skills = []

    if param.instance_of? String
      @search_string = param
    elsif param.instance_of? Array
      @user_skills = param
    else
      # TODO: Throw error.
    end
  end

  def execute(&block)
    skills = []
    
    if (@search_string.presence)
      skills = search_skills_from_search_string(&block)
    else
      skills = search_skills_from_skills(&block)
    end

    skills
  end

  private

  def search_skills_from_search_string(&block)
    skills = []

    tokenize_search_string(@search_string).each do |name|
      search_skill = create_skill(name)
      yield search_skill if block_given?
      skills << search_skill
    end

    skills
  end

  def search_skills_from_skills(&block)
    skills = []

    @user_skills.each do |skill|
      yield skill if block_given?
      skills << SearchSkill.new({skill_name: skill.name, skill_valid: skill.instance_of?(Skill)})
    end

    skills
  end

  def create_skill(skill_name) 
    search_skill = validate_skill(SearchSkill.new(skill_name: skill_name))
  end

  def validate_skill(search_skill)
    search_skill.skill_valid = Skill.exists?(['name ILIKE ?', search_skill.skill_name]) 
    search_skill
  end
end
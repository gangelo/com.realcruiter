require 'search_skill'
require 'search_skills_creator'
require 'model_helpers_transform_to_attributes'
require 'skills_search_string'

class SearchCriteria
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::Conversion
  include ModelHelpers::TransformToAttributes
  include Skills::SearchString

  validates_presence_of :search_string

  def initialize(attributes={})
    @search_skills = []
    super
  end

  def search_string
    @search_string
  end

  def search_string=(value)
    @search_string = prettify_search_string(value)
  end

  def search_skills
    @search_skills
  end

  def search_skills_attributes=(hash)
    @search_skills = []

    hash.each do |sequence, skill_values|
      skill = SearchSkill.new(skill_name: skill_values['skill_name'], skill_valid: skill_values['skill_valid'])
      @search_skills << validate_skill(skill) unless skill_duped?(skill)
    end

    interactor = SearchSkillsCreator.new(@search_string)
    interactor.execute() do |skill|
      @search_skills << skill unless skill_duped?(skill)
    end

    @search_skills.sort! { |a, b| a.skill_name <=> b.skill_name }
  end

  def attributes
    { 'search_string' => @search_string, 'search_skills' => transform_to_attributes(@search_skills) }
  end

  private

  def skill_duped?(skill)
    @search_skills.map{|s| s.skill_name.downcase }.count(skill.skill_name.downcase) >= 1
  end

  def validate_skill(search_skill)
    search_skill.skill_valid = Skill.exists?(name: search_skill.skill_name)
    search_skill
  end

  def persisted?
    false
  end
 
  def id
    nil
  end
end
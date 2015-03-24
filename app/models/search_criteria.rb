require 'search_skill'

class SearchCriteria
  include ActiveModel::Model

  attr_accessor :search_string

  validates_presence_of :search_string

  def search_skills
    @search_skills || []
  end

  def search_skills_attributes=(hash)
    @search_skill = []

    hash.each do |skill|
      @search_skills << SearchSkill.new(skill_name: skill[:skill_name], skill_valid?: skill[:skill_valid?])
    end

    @search_results
  end

  private

  def skill_valid?(skill_hash)
    skill[:skill_valid?].presence || Skill.exists?(name: skill[:skill_name])
  end
end
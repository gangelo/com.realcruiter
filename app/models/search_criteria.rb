require 'search_skill'
require 'search_skills_creator'
require 'model_helpers_pagination'
require 'model_helpers_transform_to_attributes'
require 'skills_search_string'

class SearchCriteria
  extend ActiveModel::Callbacks
  define_model_callbacks :initialize, only: :after

  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  include ActiveModel::Conversion
  include ActiveModel::Serialization

  include Skills::SearchString
  include ModelHelpers::TransformToAttributes
  include ModelHelpers::Pagination

  after_initialize :action_after_initialize

  after_validation :clear_search_string

  validates_presence_of :search_string, unless: :has_search_skills?

  def initialize(attributes={})
    @search_skills = []
    @user_profiles = UserProfile.none
    super

    self.class.default_per_page = 20

    run_callbacks :initialize do
    end
  end

  def attributes
    { 'search_string' => @search_string, 'search_skills' => transform_to_attributes(@search_skills), 'page' => paginate_params[:page], 'per_page' => paginate_params[:per_page] }
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
      @search_skills << validate_skill(skill) unless dupe_skill? skill 
    end

    interactor = SearchSkillsCreator.new(@search_string)
    interactor.execute() do |skill|
      @search_skills << skill unless dupe_skill? skill
    end

    @search_skills.sort! { |a, b| a.skill_name <=> b.skill_name }
  end

  def user_profiles
    @user_profiles
  end

  def user_profiles_attributes=(attributes)
    # Not needed, except to get fields_for in views.
  end

  def valid_search_skills
    @search_skills.reject{|skill| !skill.skill_valid}.map {|skill| skill.skill_name}
  end

  def has_search_skills?
    @search_skills.any?
  end

  protected

  def action_after_initialize
    @user_profiles = has_search_skills? ? UserProfile.find_by_skills_with_paginate(valid_search_skills, paginate_params) : @user_profiles.paginate(paginate_params)
  end

  private

  def dupe_skill?(skill)
    @search_skills.map{|s| s.skill_name.downcase }.count(skill.skill_name.downcase) >= 1
  end

  def validate_skill(search_skill)
    search_skill.skill_valid = Skill.exists?(name: search_skill.skill_name)
    search_skill
  end

  def clear_search_string
    @search_string.clear
  end
end
require 'skills_creator'
require 'model_helpers_sql_builders'

class UserProfile < ActiveRecord::Base
  include ModelHelpers::SqlBuilders

  belongs_to :user, inverse_of: :user_profiles

  has_many :user_profile_skills
  has_many :skills, through: :user_profile_skills

  has_many :custom_skills, inverse_of: :user_profile, dependent: :delete_all

  def initialize(hash={})   
    super defaults_merge(hash)
  end

  def all_skills
    (self.skills + self.custom_skills).sort_by{|skill| skill[:name]}
  end

  def all_skills_attributes=(hash)
    add_all_skills(hash)
  end

  validates_uniqueness_of :profile_name, case_sensitive: false, scope: [:user_id, :type]
  validates_presence_of :profile_name

  validates_presence_of :type, on: :create

  def self.profiles_having_skills(skills)
    where_clause = build_sql_where_clause(:skills, :name, skills)
    UserProfile.all.joins(:skills).where(where_clause)
  end

  private

  def defaults_merge(hash)
    {type: self.class}.merge(hash.presence||{})
  end

  def add_all_skills(hash)
    skills.destroy_all unless skills.empty?
    custom_skills.destroy_all unless custom_skills.empty?

    hash.each do |sequence, skill_values|
      interactor = SkillsCreator.new(self, skill_values[:name]) 
      interactor.execute do |skill|
        if skill.instance_of? Skill
          skills << skill
        elsif skill.instance_of? CustomSkill
          custom_skills << skill
        end
      end
    end
  end
end

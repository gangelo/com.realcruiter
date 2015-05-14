require 'skills_creator'
require 'model_helpers_sql_builders'

class UserProfile < ActiveRecord::Base
  include ModelHelpers::SqlBuilders

  belongs_to :user, inverse_of: :user_profiles

  has_many :user_profile_skills
  has_many :skills, through: :user_profile_skills

  has_many :custom_skills, dependent: :delete_all

  validates_uniqueness_of :profile_name, case_sensitive: false, scope: [:user_id, :type]
  validates_presence_of :profile_name

  validates_presence_of :type, on: :create, if: Proc.new { |p| 
    if p.type == TechnicalRecruiterProfile.name || p.type == SoftwareDeveloperProfile.name 
      true
    else
      errors.add(:type, "Can't be blank")
      false
    end
  }

  def initialize(hash={})   
    super defaults_merge(hash)
  end

  def all_skills
    (self.skills + self.custom_skills).sort_by{|skill| skill[:name]}
  end

  def all_skills_attributes=(hash)
    add_all_skills(hash)
  end

  def self.find_by_skills(skills, user=nil)
    return Skill.none unless skills.presence

    in_clause = build_sql_in_clause(:skills, :name, skills)
    UserProfile.joins(:skills).where(in_clause)
      .group('user_profiles.id')
      .having("COUNT(user_profiles.id) >= ? AND COUNT(user_profiles.id) <= ?", from_count(skills.count), skills.count)
      .order("COUNT(user_profiles.id) DESC, user_profiles.id")
      .reject{ |p|
        # Filter out user profiles that the current user is connected with, or, has
        # outstanding connect requests against.
        (p.user_id == user.id || user.connect_requests.where(request_user_id: p.user_id).any?) if user.presence && true
      }
  end

  def self.find_by_skills_with_paginate(skills, paginate_params={page: nil, per_page: nil}, user=nil)
    find_by_skills(skills, user).paginate(page: paginate_params[:page], per_page: paginate_params[:per_page])
  end

  private

  def self.from_count(count)
    from = count / 2
    return count if from == 0
    max(2, half(count))
  end

  def self.half(count)
    half = count / 2
    half > 1 ? half : 1
  end

  def self.max(num1, num2)
    num1 > num2 ? num1 : num2
  end

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

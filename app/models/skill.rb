require 'skills_before_create'
require 'skills_validates'

class Skill < ActiveRecord::Base
  include Skills::BeforeCreate
  include Skills::Validates

  has_many :user_profile_skills
  has_many :user_profiles, through: :user_profile_skills
end
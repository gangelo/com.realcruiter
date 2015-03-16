class Skill < ActiveRecord::Base

  has_many :user_profile_skills
	has_many :user_profiles, through: :user_profile_skills

  validates_presence_of :name
end
class Skill < ActiveRecord::Base
  has_many :user_profile_skills
	has_many :user_profiles, through: :user_profile_skills
end
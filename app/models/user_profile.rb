class UserProfile < ActiveRecord::Base
  belongs_to :user

  has_many :user_profile_skills
	has_many :skills, through: :user_profile_skills
end

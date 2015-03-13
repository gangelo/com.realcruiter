class UserProfile < ActiveRecord::Base
  belongs_to :user

  has_many :user_profile_skills
	has_many :skills, through: :user_profile_skills

	validates_uniqueness_of :profile_name, case_sensitive: false, scope: [:user_id, :type]
  validates_presence_of :profile_name

  validates_presence_of :profile_type

  attr_accessor :profile_type
end

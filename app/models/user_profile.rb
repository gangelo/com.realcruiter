class UserProfile < ActiveRecord::Base
  belongs_to :user

  has_many :user_profile_skills
	has_many :skills, through: :user_profile_skills

  accepts_nested_attributes_for :user_profile_skills

  def skills_attributes=(hash)
    skills.delete_all

    hash.each do |sequence, skill_values|
      skills << Skill.where(name: skill_values[:name]).first_or_create
    end
  end

	validates_uniqueness_of :profile_name, case_sensitive: false, scope: [:user_id, :type]
  validates_presence_of :profile_name

  validates_presence_of :profile_type, on: :create

  attr_accessor :profile_type
end

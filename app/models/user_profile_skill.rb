class UserProfileSkill < ActiveRecord::Base
  belongs_to :user_profile
  belongs_to :skill

  accepts_nested_attributes_for :skill, reject_if: :all_blank
end

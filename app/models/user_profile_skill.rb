class UserProfileSkill < ActiveRecord::Base
  belongs_to :user_profile
  belongs_to :skill
end

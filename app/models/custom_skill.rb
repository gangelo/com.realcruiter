require 'skills_before_create'
require 'skills_validates'

class CustomSkill < ActiveRecord::Base
  include Skills::BeforeCreate
  include Skills::Validates

  belongs_to :user_profile, inverse_of: :custom_skills
end

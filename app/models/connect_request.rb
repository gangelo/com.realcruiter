class ConnectRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :request, class_name: 'User'
  belongs_to :user_profile, foreign_key: :request_user_profile_id

  def self.find_by_request_token(request_token)
    self.where(request_token: request_token).first
  end
end

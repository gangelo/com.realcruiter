require 'request_status'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :user_profiles, inverse_of: :user

  has_many :connect_requests, dependent: :delete_all
  has_many :inverse_connect_requests, class_name: 'ConnectRequest', foreign_key: :request_user_id, dependent: :delete_all
  has_many :inverse_requests, through: :inverse_connect_requests, source: :user

  validates_presence_of :password_confirmation

  def connect_request_exists?(request_user_id, request_user_profile_id)
    ConnectRequest.exists?(user_id: self.id, request_user_id: request_user_id, request_user_profile_id: request_user_profile_id)
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :user_profiles, inverse_of: :user

  has_many :connections, dependent: :delete_all
  has_many :inverse_connections, class_name: 'Connection', foreign_key: :connected_user_id, dependent: :delete_all

  has_many :connect_requests, dependent: :delete_all
  has_many :inverse_connect_requests, class_name: 'ConnectRequest', foreign_key: :request_user_id, dependent: :delete_all

  validates_presence_of :password_confirmation, :first_name, :last_name

  def connect_request_exists?(request_user_id, request_user_profile_id)
    ConnectRequest.exists?(user_id: self.id, request_user_id: request_user_id, request_user_profile_id: request_user_profile_id)
  end

  def connected?(user_profile)
    self.connections.where(status: Connection::ACTIVE, connected_user_id: user_profile.user_id, connected_user_profile_id: user_profile.id).any?
  end

  def formatted_name
    "#{self.first_name} #{self.last_name}"
  end
end

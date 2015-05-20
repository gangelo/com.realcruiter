class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :user_profiles

  has_many :connect_requests, dependent: :delete_all
  has_many :inverse_connect_requests, class_name: 'ConnectRequest', foreign_key: :request_user_id, dependent: :delete_all, inverse_of: :user

  validates_presence_of :password_confirmation, :first_name, :last_name

  def connect_request_exists?(request_user_id, request_user_profile_id)
    ConnectRequest.exists?(user_id: self.id, request_user_id: request_user_id, request_user_profile_id: request_user_profile_id)
  end

  def connected?(user_profile)
    self.connect_requests.where(request_status: ConnectRequest::CONNECTED, request_user_id: user_profile.user_id, request_user_profile_id: user_profile.id).any?
  end

  def formatted_name
    "#{self.first_name} #{self.last_name}"
  end

  def all_connect_requests
    user_id = self.id
    connect_requests = ConnectRequest.where(
      ConnectRequest.arel_table[:user_id].eq(user_id).or(
        ConnectRequest.arel_table[:request_user_id].eq(user_id) 
      ) 
    )

    connect_requests.each do |connect_request|
      connect_request.instance_eval do
        def is_inverse
          instance_variable_get('@is_inverse')
        end    
        def is_inverse=(value)
          instance_variable_set('@is_inverse', value)
        end    
      end

      connect_request.is_inverse = self.id == connect_request.request_user_id
    end
  end
end

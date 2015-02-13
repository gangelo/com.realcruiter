class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :user_profiles

  validates :password_confirmation, presence: true

  def add_profile(profile_type, params={})
    # TODO: Check correct number of params passed.

    raise(ArgumentError, "profile_type must be a String or Symbol") unless profile_type.respond_to?(:empty?) && (profile_type.is_a?(String) || profile_type.is_a?(Symbol))
    raise(ArgumentError, "profile_type cannot be empty or nil") if profile_type.nil? || profile_type.empty?

    profile_type = profile_type.to_s if profile_type.is_a? Symbol

    begin
      user_profile = profile_type.classify.constantize.create(params)
      self.user_profiles << user_profile
      user_profile
    rescue
      raise ArgumentError, "Unrecognized profile type encountered: [#{profile_type}]"
    end
  end
end

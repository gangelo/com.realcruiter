class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :user_profiles

  validates :password_confirmation, presence: true

  def add_profile(profile_type, params={})
    case profile_type
      when :technical_recruiter_profile
        self.user_profiles << TechnicalRecruiterProfile.create(params)
    else
      # TODO: Redirect to error page.
      raise ArgumentError, "Unrecognized profile type encountered: [#{profile_type}]"
    end
  end
end

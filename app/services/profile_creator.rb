class ProfileCreator
  attr_reader :profile

  def initialize(params, user)
    @params = params
    @user = user
  end

  def execute
    return false unless valid_profile_class?
    @profile = create_profile
    profile.valid?
  end

  private

  def create_profile
    profile_class.create(@params.merge(user: @user))
  end

  def profile_class
    @params.fetch(:type, UserProfile.name).classify.constantize
  end

  def valid_profile_class?
    profile_class && true
  rescue
    false 
  end
end
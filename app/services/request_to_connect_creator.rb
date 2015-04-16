class RequestToConnectCreator
  attr_reader :profile

  def initialize(params)
    @user_id = params[:user_id]
    @user_profile_id = params[:user_profile_id]
  end

  def execute
    create
  end

  private

  def create
    create_request do |user, user_profile, uuid|
      send_request(user, user_profile, uuid)
      true
    end
  rescue
    false
  end

  def create_request
    user = User.find_by_id(@user_id)
    user_profile = UserProfile.find_by_id(@user_profile_id)
    uuid = unique_uuid

    record_request

    yield user, user_profile, uuid
  end

  def record_request
  end

  def send_request(user, user_profile, uuid)
    AppMailer.request_to_connect(user, user_profile, uuid).deliver_now
  rescue
  end

  def unique_uuid
    SecureRandom.uuid.gsub(/-/, '')
  end
end
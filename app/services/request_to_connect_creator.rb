class RequestToConnectCreator
  attr_reader :profile

  def initialize(user, params)
    @user = user
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
      return true
    end
    false
  rescue
    false
  end

  def create_request
    user = User.find_by_id(@user_id)
    user_profile = UserProfile.find_by_id(@user_profile_id)
    uuid = unique_uuid

    if persist_request
      yield user, user_profile, uuid
    end
  end

  def persist_request
    connect_request = @user.connect_requests.build(request_user_id: @user_id, request_user_profile_id: @user_profile_id)
    connect_request.save
  end

  def send_request(user, user_profile, uuid)
    AppMailer.request_to_connect(user, user_profile, uuid).deliver_now
  rescue
  end

  def unique_uuid
    SecureRandom.uuid.gsub(/-/, '')
  end
end
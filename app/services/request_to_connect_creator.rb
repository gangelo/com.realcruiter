class RequestToConnectCreator
  attr_reader :profile

  def initialize(user, params)
    @user = user
    @user_id = params[:user_id]
    @user_profile_id = params[:user_profile_id]
    @request_token = nil
  end

  def execute
    create
  end

  private

  def create
    create_request do |user, user_profile, request_token|
      send_request(user, user_profile, request_token)
      return true
    end
    false
  rescue
    false
  end

  def create_request
    user = User.find_by_id(@user_id)
    user_profile = UserProfile.find_by_id(@user_profile_id)
    @request_token = url_safe_request_token

    if persist_request
      yield user, user_profile, @request_token
    end
  end

  def persist_request
    connect_request = @user.connect_requests.build(request_user_id: @user_id, request_user_profile_id: @user_profile_id, request_token: @request_token)
    connect_request.save
  end

  def send_request(user, user_profile, request_token)
    AppMailer.request_to_connect(user, user_profile, request_token).deliver_now
  rescue
  end

  def url_safe_request_token
    request_token = SecureRandom.urlsafe_base64(32, false)
    return request_token unless ConnectRequest.exists?(request_token: request_token)
    url_safe_request_token
  end
end
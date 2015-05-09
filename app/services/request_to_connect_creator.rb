require 'crypted_request_to_connect_token_creator'

class RequestToConnectCreator
  attr_reader :profile

  def initialize(user, params)
    @user = user
    @user_id = params[:user_id]
    @user_profile_id = params[:user_profile_id]
    @connect_request = ConnectRequest.none
  end

  def execute(&block)
    if create
      yield @connect_request if block_given?
      send_email
      true
    else
      false
    end
  end

  private

  def create
    @connect_request = @user.connect_requests.build(request_user_id: @user_id, request_user_profile_id: @user_profile_id)
    @connect_request.save
  rescue
    false
  end

  def send_email
    interactor = CryptedRequestToConnectTokenCreator.new(@connect_request.id)
    token = interactor.execute
    AppMailer.request_to_connect(@connect_request, token).deliver_now
  rescue
  end
end
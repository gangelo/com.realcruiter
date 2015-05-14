require 'crypted_connection_token_creator'

class ConnectionCreator
  def initialize(connect_request, accept_request)
    @connect_request = connect_request
    @accept_request = accept_request 
    @connection = Connection.none
  end

  def execute
    if create
      send_email
      true
    else
      false
    end
  end  

  def accepted?
    @accept_request
  end

  private

  def create
    @connect_request.transaction do
      @connect_request.accept!
      @connect_request.save!

      request_user_id = @connect_request.request_user_id
      request_user_profile_id = @connect_request.request_user_profile_id
      @connection = @connect_request.user.connections.build(connect_request: @connect_request, connected_user_id: request_user_id, connected_user_profile_id: request_user_profile_id)
      @connection.save!
      true
    end
  rescue
    false
  end

  def send_email
    if self.accepted?
      AppMailer.request_to_connect_accepted(@connect_request).deliver_now
    else
      AppMailer.request_to_connect_rejected(@connect_request).deliver_now
    end
  rescue
  end
end
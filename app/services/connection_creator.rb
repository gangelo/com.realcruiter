require 'crypted_connection_token_creator'

class ConnectionCreator
  def initialize(connect_request, accept_request)
    @connect_request = connect_request
    @accept_request = accept_request 
  end

  def execute
    if create
      send_email
      true
    else
      false
    end
  end  

  def connected?
    @accept_request
  end

  private

  def create
    @connect_request.connect!
    @connect_request.save
  end

  def send_email
    if self.connected?
      AppMailer.request_to_connect_accepted(@connect_request).deliver_now
    else
      AppMailer.request_to_connect_rejected(@connect_request).deliver_now
    end
  rescue
  end
end
class ConnectionCreator
  def initialize(user, params)
    @user = user
    @connected_user_id = params.with_indifferent_access[:request_user_id] 
    @connected_user_profile_id = params.with_indifferent_access[:request_user_profile_id] 
  end

  def execute
    connection = @user.connections.build(connected_user_id: @connected_user_id, connected_user_profile_id: @connected_user_profile_id)
    connection.save
  rescue
    false
  end  

  private

  def send_request_accepted
    # Send the email
  rescue
  end
end
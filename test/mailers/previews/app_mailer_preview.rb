# Preview all emails at http://localhost:3000/rails/mailers/app_mailer

class AppMailerPreview < ActionMailer::Preview

  def confirmation_instructions
    AppMailer.confirmation_instructions(User.first, "faketoken", {})
  end

  def reset_password_instructions
    AppMailer.reset_password_instructions(User.first, "faketoken", {})
  end

  def unlock_instructions
    AppMailer.unlock_instructions(User.first, "faketoken", {})
  end

  def request_to_connect
    connect_request = ConnectRequest.first
  	AppMailer.request_to_connect(connect_request, "faketoken")
  end

  def request_to_connect_accepted
    connect_request = ConnectRequest.first
    AppMailer.request_to_connect_accepted(connect_request)
  end

   def request_to_connect_rejected
    connect_request = ConnectRequest.first
    AppMailer.request_to_connect_rejected(connect_request)
  end
end
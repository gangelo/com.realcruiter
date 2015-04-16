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
    user = User.first
    user_profile = user.user_profiles.first
  	AppMailer.request_to_connect(user, user_profile, "faketoken")
  end
end
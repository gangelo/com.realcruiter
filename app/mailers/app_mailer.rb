class AppMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views


  def request_to_connect(record, user_profile, token, opts={subject: 'someone wants to connect with you!'})
    @token = token
    @user_profile = user_profile

    opts[:subject] = AppMailer.build_email_subject(opts[:subject])

    devise_mail(record, :request_to_connect, opts)
  end

  protected

  def self.default_subject
    'Realcruiter.com'
  end

  def self.build_email_subject(subject)
    subject = subject.presence ? self.default_subject + ': ' + subject : self.default_subject
    subject
  end

end
class AppMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views


  def request_to_connect(record, token, opts={subject: 'someone wants to connect with you!'})
    send_mail(record, token, opts, :request_to_connect)
  end

  def request_to_connect_accepted(record, token, opts={subject: 'your connect request has been accepted!'})
    send_mail(record, token, opts, :request_to_connect_accepted)
  end

  def request_to_connect_rejected(record, opts={subject: 'your connect request has been rejected.'})
    opts[:subject] = AppMailer.build_email_subject(opts[:subject])
    devise_mail(record.user, :request_to_connect_rejected, opts)
  end

  protected

  def send_mail(record, token, opts, view)
    @token = token
    @user_profile = record.user_profile

    opts[:subject] = AppMailer.build_email_subject(opts[:subject])
    devise_mail(record.user, view, opts)
  end

  def self.default_subject
    'Realcruiter.com'
  end

  def self.build_email_subject(subject)
    subject = subject.presence ? self.default_subject + ': ' + subject : self.default_subject
    subject
  end

end
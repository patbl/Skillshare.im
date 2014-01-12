class UserMailer < ActionMailer::Base
  helper :application
  default from: "Skillshare.im <offers@skillshare.im>"

  def request_email(email)
    @email = email
    mail(@email.mail_params)
  end
end

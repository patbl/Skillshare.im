class UserMailer < ActionMailer::Base
  helper :application
  default from: "Skillshare.im <offers@skillshare.im>"

  def proposal_email(email)
    @email = email
    mail(@email.mail_params)
  end
end

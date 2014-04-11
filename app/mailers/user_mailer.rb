class UserMailer < ActionMailer::Base
  default from: "Skillshare.im <notifications@skillshare.im>"

  def proposal_email(email)
    @email = email
    mail(@email.mail_params)
  end
end

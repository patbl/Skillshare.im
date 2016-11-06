class UserMailer < Mailer
  default from: "Skillshare.im <notifications@skillshare.im>"

  def proposal_email(email)
    @email = email
    mail(@email.mail_params)
  end

  def new_login_instructions(recipient, password)
    @recipient = recipient
    @password = password
    mail(to: @recipient.email, subject: "Your new Skillshare.im password")
  end
end

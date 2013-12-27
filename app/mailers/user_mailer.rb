class UserMailer < ActionMailer::Base
  helper :application
  default from: "Skillshare.im <requests@skillshare.im>"

  def request_an_offer_email(sender, body, offer)
    @sender = sender
    @body = body
    @offer = offer
    @recipient = offer.user
    subject = %[Request for "#{@offer.title}" on Skillshare.im]
    from = "#{@recipient.name} via Skillshare.im <#{@sender.email}>"
    mail(to: @recipient.email, reply_to: @sender.email, subject: subject, from: from)
  end
end

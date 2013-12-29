class UserMailer < ActionMailer::Base
  helper :application
  default from: "Skillshare.im <requests@skillshare.im>"

  def request_notification(requester, body, offer)
    @requester = requester
    @body = body
    @offer = offer
    @offerer = offer.user
    subject = %[Request for "#{@offer.title}" on Skillshare.im]
    from = "#{@offerer.name} via Skillshare.im <#{@requester.email}>"
    mail(to: @offerer.email, reply_to: @requester.email, subject: subject, from: from)
  end

  def request_confirmation(requester, body, offer)
    @requester = requester
    @body = body
    @offer = offer
    @offerer = offer.user
    subject = %[Confirmation of request for "#{@offer.title}" on Skillshare.im]
    from = "Skillshare.im"
    mail(to: @requester.email, reply_to: @offerer.email, subject: subject, from: from)
  end
end

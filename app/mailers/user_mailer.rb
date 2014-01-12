class UserMailer < ActionMailer::Base
  helper :application
  default from: "Skillshare.im <offers@skillshare.im>"

  def request_email(requester, body, offer, notification: true)
    @body = body
    @offer = offer
    if notification
      @from_user = requester
      @to_user = offer.user
      subject = %[Request for "#{@offer.title}" on Skillshare.im]
    else
      @from_user = offer.user
      @to_user = requester
      subject = %[Confirmation of request for "#{@offer.title}" on Skillshare.im]
    end
    mail(to: @to_user.email, reply_to: @from_user.email, subject: subject)
  end
end

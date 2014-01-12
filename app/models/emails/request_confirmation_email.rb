class RequestConfirmationEmail < RequestEmail
  def initialize(*)
    super
    @sender = @offer.user
    @recipient = @user
    subject = %[Confirmation of request for "#{@offer.title}" on Skillshare.im]
  end

  def mail_params
    { to: @recipient.email, reply_to: @sender.email, subject: @subject }
  end
end

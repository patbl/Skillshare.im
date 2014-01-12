class RequestNotificationEmail < RequestEmail
  def initialize(*)
    super
    @sender = @user
    @recipient = @offer.user
    @subject = %[Request for "#{@offer.title}" on Skillshare.im]
  end

  def mail_params
    {to: @recipient.email, reply_to: @sender.email, subject: @subject }
  end
end

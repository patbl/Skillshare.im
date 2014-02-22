class NotificationEmail < ProposalEmail
  def initialize(*)
    super
    @sender = @user
    @recipient = @proposal.user
    @subject = %[New message about "#{@proposal.title}"]
  end

  def mail_params
    { to: @recipient.email, reply_to: @sender.email, subject: @subject }
  end
end

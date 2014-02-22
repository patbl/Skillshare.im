class ConfirmationEmail < ProposalEmail
  def initialize(*)
    super
    @sender = @proposal.user
    @recipient = @user
    @subject = %[Your message about "#{@proposal.title}" was sent]
  end

  def mail_params
    { to: @recipient.email, reply_to: @sender.email, subject: @subject }
  end
end

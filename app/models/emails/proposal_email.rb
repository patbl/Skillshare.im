class ProposalEmail
  attr_reader :body, :sender, :recipient, :proposal

  def initialize(user, body, proposal)
    @user, @body, @proposal = user, body, proposal
  end

  def recipient_name
    @recipient.name
  end

  def sender_name
    @sender.name
  end

  def proposal_title
    @proposal.title
  end

  def template
    "user_mailer/#{self.class.to_s.underscore}"
  end
end

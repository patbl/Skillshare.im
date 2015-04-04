class ProposalEmail
  attr_reader :body, :sender, :recipient, :proposal

  def initialize(user, body, proposal)
    @user, @body, @proposal = user, body, proposal
  end

  def recipient_name
    @recipient.first_name
  end

  def sender_first_name
    @sender.first_name
  end

  def sender_full_name
    @sender.full_name
  end

  def proposal_title
    @proposal.title
  end

  def body_template
    "user_mailer/#{self.class.to_s.underscore}_body"
  end

  def footer_template
    "user_mailer/#{self.class.to_s.underscore}_footer"
  end
end

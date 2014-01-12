class RequestEmail
  attr_reader :body, :sender, :recipient, :offer

  def initialize(user, body, offer)
    @user, @body, @offer = user, body, offer
  end

  def recipient_name
    @recipient.name
  end

  def sender_name
    @sender.name
  end

  def offer_title
    @offer.title
  end

  def template
    "user_mailer/#{self.class.to_s.underscore}"
  end
end

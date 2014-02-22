class OfferDecorator < ProposalDecorator
  include Draper::LazyHelpers

  delegate_all

  def noun
    "offer"
  end

  def verb
    "request"
  end

  def create_message_url
    offer_messages_url(self)
  end

  def show_url
    offer_url(self)
  end

  def default_message
    "I would like to accept your offer!"
  end
end

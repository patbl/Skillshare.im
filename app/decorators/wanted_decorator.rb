class WantedDecorator < ProposalDecorator
  include Draper::LazyHelpers

  delegate_all

  def noun
    "wanted"
  end

  def verb
    "offer"
  end

  def create_message_url
    offer_messages_url(self)
  end

  def show_url
    wanted_url(self)
  end

  def default_message
    "I would like to fulfill your request!"
  end
end

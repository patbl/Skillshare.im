class OfferDecorator < ProposalDecorator
  include Draper::LazyHelpers

  delegate_all

  def noun
    "offer"
  end

  def verb
    "request"
  end
end

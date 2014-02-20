class WantedDecorator < ProposalDecorator
  include Draper::LazyHelpers

  delegate_all

  def noun
    "wanted"
  end

  def verb
    "offer"
  end
end

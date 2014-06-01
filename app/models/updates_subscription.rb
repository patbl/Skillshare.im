class UpdatesSubscription < Subscription
  def description
    "New offers and requests"
  end

  def new_items
    Proposal.where(created_at: self.period).count
  end
end

class Wanted < Proposal
  has_many :fulfillments

  def record(fulfiller)
    Fulfillment.record_fulfillment(self, fulfiller)
  end
end

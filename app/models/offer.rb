class Offer < Proposal
  has_many :requisitions

  def record(requester)
    Requisition.create_requisition(requester, self)
  end
end

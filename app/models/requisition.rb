class Requisition < ActiveRecord::Base
  include Measurable
  
  belongs_to :requester, class_name: "User"
  belongs_to :offerer, class_name: "User"
  belongs_to :offer

  def self.create_requisition(requester, offer)
    offerer = offer.user
    create requester: requester, offerer: offerer, offer: offer
  end
end

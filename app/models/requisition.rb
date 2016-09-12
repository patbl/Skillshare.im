class Requisition < ApplicationRecord
  include Measurable

  belongs_to :requester, class_name: "User"
  belongs_to :offerer, class_name: "User"
  belongs_to :offer

  def self.create_requisition(requester, offer)
    offerer = offer.user
    create requester: requester, offerer: offerer, offer: offer
  end
end

# == Schema Information
#
# Table name: requisitions
#
#  id           :integer          not null, primary key
#  requester_id :integer
#  offerer_id   :integer
#  offer_id     :integer
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_requisitions_on_offer_id      (offer_id)
#  index_requisitions_on_offerer_id    (offerer_id)
#  index_requisitions_on_requester_id  (requester_id)
#

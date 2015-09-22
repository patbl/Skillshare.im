class Offer < Proposal
  has_many :requisitions

  def record(requester)
    Requisition.create_requisition(requester, self)
  end
end

# == Schema Information
#
# Table name: proposals
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  type        :string(255)
#
# Indexes
#
#  index_proposals_on_user_id  (user_id)
#

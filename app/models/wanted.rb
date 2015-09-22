class Wanted < Proposal
  has_many :fulfillments

  def record(fulfiller)
    Fulfillment.record_fulfillment(self, fulfiller)
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

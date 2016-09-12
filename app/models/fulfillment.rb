class Fulfillment < ApplicationRecord
  include Measurable

  belongs_to :fulfiller, class_name: "User"
  belongs_to :wanter, class_name: "User"
  belongs_to :wanted

  def self.record_fulfillment(wanted, fulfiller)
    wanter = wanted.user
    create(wanted: wanted, fulfiller: fulfiller, wanter: wanter)
  end
end

# == Schema Information
#
# Table name: fulfillments
#
#  id           :integer          not null, primary key
#  fulfiller_id :integer
#  wanter_id    :integer
#  wanted_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_fulfillments_on_fulfiller_id  (fulfiller_id)
#  index_fulfillments_on_wanted_id     (wanted_id)
#  index_fulfillments_on_wanter_id     (wanter_id)
#

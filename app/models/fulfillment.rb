class Fulfillment < ActiveRecord::Base
  include Measurable

  belongs_to :fulfiller, class_name: "User"
  belongs_to :wanter, class_name: "User"
  belongs_to :wanted

  def self.record_fulfillment(wanted, fulfiller)
    wanter = wanted.user
    create(wanted: wanted, fulfiller: fulfiller, wanter: wanter)
  end
end

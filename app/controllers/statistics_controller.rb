class StatisticsController < ApplicationController
  skip_before_action :authorize
  def index
    @user_count = User.count
    @offer_count = Offer.count
    @wanted_count = Wanted.count
    @requisition_count = Requisition.count
    @fulfillment_count = Fulfillment.count
    @fulfillments_by_month = Fulfillment.group_by_month
    @requisitions_by_month = Requisition.group_by_month
  end
end

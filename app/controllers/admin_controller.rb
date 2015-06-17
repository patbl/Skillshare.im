class AdminController < ApplicationController
  skip_before_action :authorize

  def statistics
    @user_count = User.count
    @offer_count = Offer.count
    @wanted_count = Wanted.count
    @requisition_count = Requisition.count
    @fulfillment_count = Fulfillment.count
    @fulfillments_by_month = Fulfillment.group_by_month
    @requisitions_by_month = Requisition.group_by_month
  end

  def recent
    start_time = Integer(params[:days]).days.ago
    @offers = Offer.where("created_at > ?", start_time)
    @wanteds = Wanted.where("created_at > ?", start_time)
  end
end

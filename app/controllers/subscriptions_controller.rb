class SubscriptionsController < ApplicationController
  skip_before_action :authorize, only: :unsubscribe

  def unsubscribe
    subscription = Subscription.find_by secure_key: params[:secure_key]
    if subscription
      subscription.update active: false
      redirect_to root_path, success: "You have been unsubscribed from this mailing."
    else
      redirect_to root_path, error: "Invalid unsubscribe link."
    end
  end
end

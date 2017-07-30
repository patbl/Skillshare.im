class SubscriptionMailer < Mailer
  default from: "Skillshare.im <updates@skillshare.im>", reply_to: ENV["SKILLSHARE_SUPPORT_EMAIL"]

  def updates(subscription)
    @user = subscription.user
    @offers = Offer.where created_at: subscription.period
    @wanteds = Wanted.where created_at: subscription.period
    @subscription = subscription
    mail(to: @user.email, subject: "New offers and requests on Skillshare.im")
  end
end

class SubscriptionMailer < ActionMailer::Base
  helper :application
  default from: "updates@skillshare.im", reply_to: "pbrinichlanglois@gmail.com"

  def updates(subscription)
    @user = subscription.user
    @offers = Offer.where created_at: subscription.period
    @wanteds = Wanted.where created_at: subscription.period
    mail(to: @user.email, subject: "New offers and wanteds on Skillshare.im")
  end
end

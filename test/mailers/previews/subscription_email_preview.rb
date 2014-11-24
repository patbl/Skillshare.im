class SubscriptionMailerPreview < ActionMailer::Preview
  def updates_email
    subscription = FactoryGirl.create :updates_subscription
    FactoryGirl.create_list :offer, 3
    FactoryGirl.create_list :wanted, 1
    SubscriptionMailer.updates(subscription)
  end
end

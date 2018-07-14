class MailerPreview < ActionMailer::Preview
  def updates_email
    subscription = FactoryBot.create :updates_subscription
    FactoryBot.create_list :offer, 3
    FactoryBot.create_list :wanted, 1
    SubscriptionMailer.updates(subscription)
  end

  def request_confirmation_email
    offer = FactoryBot.create(:offer)
    user = FactoryBot.create(:user, first_name: "Requester")
    email = ConfirmationEmail.new(user, Faker::HipsterIpsum.paragraphs.join("\n\n"), offer)
    UserMailer.proposal_email(email)
  end

  def offer_confirmation_email
    request = FactoryBot.create(:wanted)
    user = FactoryBot.create(:user, first_name: "Offerer")
    email = ConfirmationEmail.new(user, Faker::HipsterIpsum.paragraphs.join("\n\n"), request)
    UserMailer.proposal_email(email)
  end

  def request_notification_email
    offer = FactoryBot.create(:offer)
    user = FactoryBot.create(:user, first_name: "Requester")
    email = NotificationEmail.new(user, Faker::HipsterIpsum.paragraphs.join("\n\n"), offer)
    UserMailer.proposal_email(email)
  end

  def offer_notification_email
    request = FactoryBot.create(:wanted)
    user = FactoryBot.create(:user, first_name: "Offerer")
    email = NotificationEmail.new(user, Faker::HipsterIpsum.paragraphs.join("\n\n"), request)
    UserMailer.proposal_email(email)
  end
end

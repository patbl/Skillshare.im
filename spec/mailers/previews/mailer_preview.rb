class MailerPreview < ActionMailer::Preview
  def updates_email
    subscription = FactoryGirl.create :updates_subscription
    FactoryGirl.create_list :offer, 3
    FactoryGirl.create_list :wanted, 1
    SubscriptionMailer.updates(subscription)
  end

  def request_confirmation_email
    offer = FactoryGirl.create(:offer)
    user = FactoryGirl.create(:user, first_name: "Requester")
    email = ConfirmationEmail.new(user, Faker::HipsterIpsum.paragraphs.join("\n\n"), offer)
    UserMailer.proposal_email(email)
  end

  def offer_confirmation_email
    request = FactoryGirl.create(:wanted)
    user = FactoryGirl.create(:user, first_name: "Offerer")
    email = ConfirmationEmail.new(user, Faker::HipsterIpsum.paragraphs.join("\n\n"), request)
    UserMailer.proposal_email(email)
  end

  def request_notification_email
    offer = FactoryGirl.create(:offer)
    user = FactoryGirl.create(:user, first_name: "Requester")
    email = NotificationEmail.new(user, Faker::HipsterIpsum.paragraphs.join("\n\n"), offer)
    UserMailer.proposal_email(email)
  end

  def offer_notification_email
    request = FactoryGirl.create(:wanted)
    user = FactoryGirl.create(:user, first_name: "Offerer")
    email = NotificationEmail.new(user, Faker::HipsterIpsum.paragraphs.join("\n\n"), request)
    UserMailer.proposal_email(email)
  end

  def new_login_instructions
    user = User.order("random()").take
    UserMailer.new_login_instructions(user, "hunter2")
  end
end

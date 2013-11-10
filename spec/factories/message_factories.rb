require 'ffaker'

FactoryGirl.define do
  factory :message do
    subject Faker::Lorem.sentence
    body Faker::Lorem.paragraphs.join("\n\n")
    proposal

    factory :message_with_users do
      after(:create) do |message|
        sender = create :user
        recipient = create :user
        message.update(sender_id: sender.id, recipient_id: recipient.id)
      end
    end
  end
end

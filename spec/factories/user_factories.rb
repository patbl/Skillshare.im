require 'ffaker'

FactoryGirl.define do
  factory :user do |n|
    provider "facebook"
    sequence(:uid) { |n| "uid#{n}" }
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    location "#{Faker::Address.city}, #{Faker::Address.country}"
    sequence(:oauth_token) { |n| "oauth#{n}" }
    oauth_expires_at 1.month.from_now

    factory :admin do
      admin true
    end

    factory :user_with_proposals do
      ignore do
        proposals_count 5
      end
      after(:create) do |user, evaluator|
        create_list(:proposal, evaluator.proposals_count, user: user)
      end
    end
  end
end

require 'ffaker'

FactoryBot.define do
  factory :user do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    sequence(:email) { |n| "#{first_name}_#{last_name}#{n}@gmail.com".downcase }
    location "#{FFaker::Address.city}, #{FFaker::Address.country}"
    sequence(:oauth_token) { |n| "oauth#{n}" }
    about FFaker::Lorem.paragraphs.join "\n\n"
    oauth_expires_at 1.month.from_now

    factory :admin do
      admin true
    end

    factory :user_with_offers do
      transient do
        offers_count 5
      end
      after(:create) do |user, evaluator|
        create_list(:offer, evaluator.offers_count, user: user)
      end
    end

    trait :has_password do
      password_identity
    end
  end
end

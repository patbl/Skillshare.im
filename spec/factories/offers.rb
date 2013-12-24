require 'ffaker'

FactoryGirl.define do
  factory :offer do
    title Faker::Lorem.sentence[10..30]
    description Faker::Lorem.paragraphs.join("\n\n")
    location "#{Faker::Address.city}, #{Faker::Address.country}"
    category_list ApplicationHelper::CATEGORIES.sample
    user

    after(:build) do |offer|
      offer.update(location: offer.user.location)
    end

    factory :invalid_offer do
      title nil
    end

    factory :request do
      offer false
    end
  end
end

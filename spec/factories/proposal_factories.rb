require 'ffaker'

FactoryGirl.define do
  factory :proposal do
    title Faker::Lorem.sentence[10..30]
    description Faker::Lorem.paragraphs.join("\n\n")
    location "#{Faker::Address.city}, #{Faker::Address.country}"
    category_list ApplicationHelper::CATEGORIES.sample
    user

    after(:build) do |proposal|
      proposal.update(location: proposal.user.location)
    end

    factory :invalid_proposal do
      title nil
    end

    factory :offer do
      offer true
    end

    factory :request do
      offer false
    end
  end
end

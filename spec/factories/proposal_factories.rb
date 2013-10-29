require 'ffaker'

FactoryGirl.define do
  factory :proposal do
    title "a free bed"
    description "Mi casa es su casa. Pero no abrazos, por favor"
    location "#{Faker::Address.city}, #{Faker::Address.country}"
    category Faker::Lorem.word
    offer true
    user

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

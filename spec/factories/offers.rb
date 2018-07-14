require 'ffaker'

FactoryBot.define do
  factory :offer do
    title FFaker::Lorem.sentence[10..30]
    description FFaker::Lorem.paragraphs.join("\n\n")
    category_list ApplicationHelper::CATEGORIES.sample
    user

    factory :invalid_offer do
      title nil
    end
  end
end

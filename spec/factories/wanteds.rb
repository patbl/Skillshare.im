require 'ffaker'

FactoryGirl.define do
  factory :wanted do
    title Faker::Lorem.sentence[10..30]
    description Faker::Lorem.paragraphs.join("\n\n")
    location "Anywhere"
    category_list ApplicationHelper::CATEGORIES.sample
    user

    factory :invalid_wanted do
      title nil
    end
  end
end

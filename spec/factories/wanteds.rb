require 'ffaker'

FactoryBot.define do
  factory :wanted do
    title { FFaker::Lorem.sentence[10..30] }
    description { FFaker::Lorem.paragraphs.join("\n\n") }
    category_list { ApplicationHelper::CATEGORIES.sample }
    user

    factory :invalid_wanted do
      title { nil }
    end
  end
end

FactoryBot.define do
  factory :identity do
    provider { "MyString" }
    sequence(:uid) { |n| "uid#{n}" }
    user { nil }

    factory :identity_with_user do
      user
    end
  end
end

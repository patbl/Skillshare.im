FactoryGirl.define do
  factory :identity do
    provider "MyString"
    uid "MyString"
    user nil

    factory :identity_with_user do
      user
    end
  end
end

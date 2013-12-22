FactoryGirl.define do
  factory :identity do
    provider "MyString"
    uid "MyString"
    email "MyString"
    name "MyString"
    location "MyString"
    latitude 1.5
    longitude 1.5
    oauth_token "MyString"
    oauth_expires_at "2013-12-21 10:06:47"
    user nil
  end
end

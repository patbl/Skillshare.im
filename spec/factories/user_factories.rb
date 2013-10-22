FactoryGirl.define do
  factory :user do |n|
    provider "facebook"
    sequence(:uid) { |n| "uid#{n}" }
    first_name "Joan" 
    last_name "Rivers" 
    sequence(:email) { |n| "joan#{n}@joan.com" }
    location "Malibu, California"
    sequence(:oauth_token) { |n| "oauth#{n}" }
    oauth_expires_at 1.month.from_now
  end
end

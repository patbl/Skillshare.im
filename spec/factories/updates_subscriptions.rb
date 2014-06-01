FactoryGirl.define do
  factory :updates_subscription do
    user
    frequency :biweekly
  end
end

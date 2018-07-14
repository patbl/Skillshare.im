FactoryBot.define do
  factory :updates_subscription do
    user
    frequency :biweekly
    last_sent Date.today
  end
end

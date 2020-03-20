# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :requisition do
    requester { nil }
    offerer { nil }
    offer { nil }
  end
end

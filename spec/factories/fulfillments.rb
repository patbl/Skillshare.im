# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :fulfillment do
    fulfiller nil
    wanter nil
    wanted nil
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fulfillment do
    fulfiller nil
    wanter nil
    wanted nil
  end
end

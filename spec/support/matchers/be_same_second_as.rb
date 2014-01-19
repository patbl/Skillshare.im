RSpec::Matchers.define :be_same_second_as do |expected_time|
  match do |actual_time|
    actual_time.to_i == expected_time.to_i
  end

  failure_message_for_should do |actual|
    "expected #{actual_time} would be the same second as #{expected_time}"
  end

  failure_message_for_should_not do |actual|
    "expected #{actual_time} would not be the same second as #{expected_time}"
  end

  description do
    "be the same time as #{expected_time}"
  end
end

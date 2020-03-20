FactoryBot.define do
  factory :password_identity do
    password_digest { SecureRandom.hex(5) }
    user
  end
end

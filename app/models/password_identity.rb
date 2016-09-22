class PasswordIdentity < ApplicationRecord
  belongs_to :user

  has_secure_password
end

# == Schema Information
#
# Table name: password_identities
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  password_digest :string           not null
#
# Indexes
#
#  index_password_identities_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_a23b38fed0  (user_id => users.id)
#

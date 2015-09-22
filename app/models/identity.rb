class Identity < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :provider, :uid
  validates_uniqueness_of :uid, scope: :provider

  def self.find_or_create(auth)
    where(auth.slice(:uid, :provider)).first_or_create
  end
end

# == Schema Information
#
# Table name: identities
#
#  id               :integer          not null, primary key
#  provider         :string(255)
#  uid              :string(255)
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_identities_on_user_id  (user_id)
#

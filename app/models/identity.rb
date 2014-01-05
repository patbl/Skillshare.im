class Identity < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :provider, :uid
  validates_uniqueness_of :uid, scope: :provider

  def self.find_or_create(auth)
    where(auth.slice(:uid, :provider)).first_or_create
  end
end

class Identity < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :provider, :uid

  def self.find_or_create_with_omniauth(auth)
    where(auth.slice(:uid, :provider)).first_or_create
  end
end

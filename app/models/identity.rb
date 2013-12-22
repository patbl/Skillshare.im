class Identity < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :provider, :uid, :email

  def self.find_with_omniauth(auth)
    find_by provider: auth.provider, uid: auth.uid
  end

  def self.create_with_omniauth(auth)
    identity = self.new(
      provider: auth.provider,
      uid:      auth.uid,
      email:    auth.info.email,
      name:     auth[:name],
      location: auth[:location],
    )

    identity.save!
    identity
  end
end

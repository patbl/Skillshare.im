class User < ActiveRecord::Base
  # has_many :proposals, dependent: destroy
  validates_presence_of :provider, :uid
  validates_uniqueness_of :uid # TODO a punctilio: maybe uid should be unique per provider
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.location = auth.info.location
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

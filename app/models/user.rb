class User < ActiveRecord::Base
  has_many :proposals, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :identities, dependent: :destroy

  include Mappable

  validates_presence_of :provider, :uid, :email, :location, :name
  validates_uniqueness_of :uid, scope: :provider

  def self.create_from_auth(auth)
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      set_facebook_info(user, auth) if auth.provider == 'facebook'
      user.location ||= "Somewhere, World"
    end
  end

  def picture(size = 'large')
    "http://graph.facebook.com/#{uid}/picture?type=#{size}"
  end

  private

  def self.set_facebook_info(user, auth)
    user.facebook_url = auth.info.urls[:Facebook]
    user.location = auth.info.location
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  end
end

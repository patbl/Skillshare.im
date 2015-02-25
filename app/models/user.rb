class User < ActiveRecord::Base
  has_many :proposals,     dependent: :destroy
  has_many :offers,        dependent: :destroy
  has_many :wanteds,       dependent: :destroy
  has_many :identities,    dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  after_create :subscribe_user

  include Mappable

  validates_presence_of :email
  validates_presence_of :first_name, :last_name, :location, on: :update

  accepts_nested_attributes_for :subscriptions

  def self.create_from_auth(auth)
    create! do |user|
      auth_hash = OmniAuth::AuthHash.new(auth)
      user.email = auth_hash.info.email
      user.first_name = user.email.split("@").first.capitalize
      user.last_name = "Surname"
      set_facebook_info(user, auth_hash) if auth_hash.provider == "facebook"
    end
  end

  def to_url
    "http://skillshare.im/users/#{self.id}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def self.set_facebook_info(user, auth)
    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.location = auth.info.location
    user.facebook_url = auth.info.urls[:Facebook]

    # remove attributes from the end of URL ("?type=normal" in the example below)
    # http://graph.facebook.com/632817960/picture?type=normal
    user.avatar_url = auth.info.image.sub(/\?.*/, "")

    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  end

  def subscribe_user
    UpdatesSubscription.create(user: self, active: true, frequency: :biweekly, last_sent: Date.today)
  end
end

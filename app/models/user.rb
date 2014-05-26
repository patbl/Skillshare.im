class User < ActiveRecord::Base
  has_many :proposals,     dependent: :destroy
  has_many :offers,        dependent: :destroy
  has_many :wanteds,       dependent: :destroy
  has_many :identities,    dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  after_create :subscribe_user

  include Mappable

  validates_presence_of :email, :location, :name
  validate :valid_name, on: :update
  validate :valid_location, on: :update

  accepts_nested_attributes_for :subscriptions

  LOCATION_PLACEHOLDER = "Your location here"
  NAME_PLACEHOLDER = "Your name here"

  def self.create_from_auth(auth)
    create! do |user|
      user.email = auth.info.email
      set_facebook_info(user, auth) if auth.provider == "facebook"
      user.name ||= NAME_PLACEHOLDER
      user.location ||= LOCATION_PLACEHOLDER
    end
  end

  private

  def self.set_facebook_info(user, auth)
    user.name = auth.info.name
    user.location = auth.info.location
    user.facebook_url = auth.info.urls[:Facebook]

    # remove attributes from the end of URL ("?type=normal" in the example below)
    # http://graph.facebook.com/632817960/picture?type=normal
    user.avatar_url = auth.info.image.sub(/\?.*/, "")

    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  end

  def subscribe_user
    Subscription.create(user: self, active: true, frequency: :biweekly, name: :updates)
  end

  def valid_name
    errors.add(:name, %["#{name}" isn't a valid name]) if name == NAME_PLACEHOLDER
  end

  def valid_location
    errors.add(:location, %["#{location}" isn't a valid location]) if location == LOCATION_PLACEHOLDER
  end
end

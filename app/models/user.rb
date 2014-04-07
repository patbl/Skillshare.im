class User < ActiveRecord::Base
  has_many :proposals,     dependent: :destroy
  has_many :offers,        dependent: :destroy
  has_many :wanteds,       dependent: :destroy
  has_many :identities,    dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  after_create :subscribe_user

  include Mappable

  validates_presence_of :email, :location, :name

  def self.create_from_auth(auth)
    create! do |user|
      user.email = auth.info.email
      set_facebook_info(user, auth) if auth.provider == "facebook"
      user.name ||= "Your name here"
      user.location ||= "Your location here"
    end
  end

  # DELETE
  def linked_to_facebook?
    !!facebook_url
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
    Subscription.create(user: self)
  end
end

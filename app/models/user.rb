class User < ActiveRecord::Base
  has_many :proposals, dependent: :destroy
  has_many :messages_received, class_name: "Message", foreign_key: "recipient_id"
  has_many :messages_sent, class_name: "Message", foreign_key: "sender_id"

  acts_as_messageable

  include Mappable

  validates_presence_of :provider, :uid, :email, :location
  validates_uniqueness_of :uid

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.location = auth.info.location || "Somewhere, World"
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def mailboxer_email(message)
    email
  end

  def picture(size = 'large')
    "http://graph.facebook.com/#{self.uid}/picture?type=#{size}"
  end
end

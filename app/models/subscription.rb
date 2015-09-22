class Subscription < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user, :frequency
  enum frequency: [:biweekly]
  before_create :generate_secure_key

  FREQUENCIES = {
    "biweekly" => 14
  }

  def generate_secure_key
    self.secure_key = SecureRandom.urlsafe_base64
  end

  def days_in_period
    FREQUENCIES[frequency]
  end

  def period
    last_sent...Date.tomorrow
  end

  def due?(current_time = Time.now)
    ((current_time - last_sent) / 1.day).to_i >= days_in_period
  end

  def ready?
    active? && due?
  end

  def send_email
    send_email! if ready?
  end

  def self.send_emails
    Subscription.all.each(&:send_email)
  end
end

# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  active     :boolean
#  frequency  :integer
#  created_at :datetime
#  updated_at :datetime
#  secure_key :string(255)
#  type       :string(255)
#  last_sent  :datetime
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#

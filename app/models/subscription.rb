class Subscription < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user, :frequency
  enum frequency: [:biweekly]
  before_save :generate_secure_key

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

  def due?(current_date = Date.today)
    current_date - last_sent >= days_in_period
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

class Subscription < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user, :frequency, :name
  enum frequency: [:biweekly]
  enum name: [:updates]

  EPOCH = Date.new(1970, 1, 1)
  FREQUENCIES = {
    "biweekly" => 14
  }

  def description
    "New offers and wanteds (#{frequency})"
  end

  def days_in_period
    FREQUENCIES[frequency]
  end

  def period
    beginning_of_period = (days_in_period - 1).days.ago
    beginning_of_period...Date.tomorrow
  end

  def due?(date = Date.today)
    days_since_epoch = date - EPOCH
    (days_since_epoch).modulo(days_in_period).zero?
  end

  def ready?
    active? && due?
  end

  def send_email
    send_email! if ready?
  end

  def send_email!
    SubscriptionMailer.public_send(name, self).deliver
  end

  def self.send_emails
    Subscription.all.each(&:send_email)
  end
end
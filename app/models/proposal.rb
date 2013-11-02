class Proposal < ActiveRecord::Base
  belongs_to :user
  validates :title, length: { minimum: 4, maximum: 70 }
  validates :description, length: { minimum: 20, maximum: 3000 }
  validates_presence_of :title, :location, :category, :description, :user

  scope :requests, -> { where offer: false }
  scope :offers, -> { where offer: true }
  scope :recent, ->(n = 10) { order(created_at: :desc).limit(n) }

  def request?
    !offer?
  end
end

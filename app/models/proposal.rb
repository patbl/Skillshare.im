class Proposal < ActiveRecord::Base
  belongs_to :user
  validates :title, length: { minimum: 4, maximum: 70 }
  validates :description, length: { minimum: 20, maximum: 3000 }
  validates_presence_of :location, :category, :description, :user

  scope :requests, -> { where offer: false }
  scope :offers, -> { where offer: true }

  def request?
    !offer?
  end
end

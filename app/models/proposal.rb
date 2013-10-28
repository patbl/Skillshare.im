class Proposal < ActiveRecord::Base
  belongs_to :user
  validates :title, length: { minimum: 4, maximum: 70 }
  validates :description, length: { minimum: 20, maximum: 3000 }
  validates_presence_of :location, :category, :description
  scope :offers, -> { where offer: true }
  scope :requests, -> { where offer: false }

  def request?
    !offer?
  end

end

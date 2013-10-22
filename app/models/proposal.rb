class Proposal < ActiveRecord::Base
  belongs_to :user
  validates :title, length: { minimum: 4, maximum: 70 }
  validates :body, length: { minimum: 20, maximum: 3000 }
  validates_presence_of :location, :category, :offer
end

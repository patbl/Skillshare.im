class Proposal < ActiveRecord::Base
  belongs_to :user
  has_many :messages
  acts_as_taggable_on :categories

  validates :title, length: { minimum: 4, maximum: 70 }
  validates :description, length: { minimum: 20, maximum: 3000 }
  # validates :category, inclusion: { in: ApplicationHelper::CATEGORIES,
    # message: "%{value} is not a valid category" }
  validates_presence_of :title, :location, :description, :user, :category_list

  scope :requests, -> { where offer: false }
  scope :offers, -> { where offer: true }
  scope :recent, ->(n = 10) { order(created_at: :desc).limit(n) }

  def request?
    !offer?
  end
end

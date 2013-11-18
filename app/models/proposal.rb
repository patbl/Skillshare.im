class Proposal < ActiveRecord::Base
  belongs_to :user
  has_many :messages
  acts_as_taggable_on :categories

  include Mappable

  validates :title, length: { minimum: 4, maximum: 70 }
  validates_presence_of :title, :location, :user, :category_list
  validate :valid_category

  scope :requests, -> { where offer: false }
  scope :offers, -> { where offer: true }
  scope :recent, ->(n = 10) { order(created_at: :desc).limit(n) }
  scope :tagged_with_or_all, ->(tag = nil) { tag ? tagged_with(tag) : all }

  def request?
    !offer?
  end

  private
  
  def valid_category
    category_list.each do |category|
      unless ApplicationHelper::CATEGORIES.member?(category)
        errors.add(:category_list, "#{category} isn't a valid category.")
      end
    end
  end
end

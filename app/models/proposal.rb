class Proposal < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable_on :categories

  include Mappable

  validates :title, length: { minimum: 3, maximum: 70 }
  validates_presence_of :title, :location, :user, :category_list
  validate :valid_category

  scope :recent, ->(n = 50) { order(created_at: :desc).limit(n) }
  scope :filter_by_tag, ->(tag = nil) { (tag ? tagged_with(tag) : all).order(created_at: :desc) }

  private

  def valid_category
    category_list.each do |category|
      unless ApplicationHelper::CATEGORIES.member?(category)
        errors.add(:category_list, "#{category} isn't a valid category.")
      end
    end
  end
end

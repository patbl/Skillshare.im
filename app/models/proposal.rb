class Proposal < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable_on :categories

  validates :title, length: { minimum: 3, maximum: 70 }
  validates_presence_of :title, :user, :category_list

  scope :recent, ->(n = 10) { order(created_at: :desc).limit(n) }
  scope :filter_by_tag, ->(tag = nil) { (tag ? tagged_with(tag) : all).order(created_at: :desc) }
end

# == Schema Information
#
# Table name: proposals
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  type        :string(255)
#
# Indexes
#
#  index_proposals_on_user_id  (user_id)
#

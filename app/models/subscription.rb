class Subscription < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user

  def name
    "New offers and wanteds (every two weeks)"
  end
end

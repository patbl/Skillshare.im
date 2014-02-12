module Mappable
  extend ActiveSupport::Concern

  included do
    geocoded_by :location
    after_validation :geocode, if: [:location_changed?, :somewhere?]
    scope :mappable, -> { where.not(longitude: nil, latitude: nil) }
  end

  def somewhere?
    location != "Anywhere"
  end
end

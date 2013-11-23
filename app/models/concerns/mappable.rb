module Mappable
  extend ActiveSupport::Concern

  included do
    geocoded_by :location
    after_validation :geocode, if: :location_changed?
    scope :mappable, -> { where("longitude") }
  end

  def latlng
    [latitude, longitude]
  end
end

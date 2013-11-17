module Mappable
  extend ActiveSupport::Concern

  included do
    geocoded_by :location
    after_validation :geocode, if: :location_changed?
  end
  
  def latlng
    [latitude, longitude]
  end
end

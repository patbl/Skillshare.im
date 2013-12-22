module Mappable
  extend ActiveSupport::Concern

  included do
    geocoded_by :location
    after_validation :geocode, if: [:location_changed?, :somewhere?]
    scope :mappable, -> { where("longitude IS NOT null AND
                                 latitude IS NOT null") }
  end

  def somewhere?
    location != "Anywhere"
  end
end

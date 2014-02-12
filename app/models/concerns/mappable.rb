module Mappable
  extend ActiveSupport::Concern

  included do
    geocoded_by :location
    after_validation :geocode, if: :needs_geocoding?

    scope :mappable, -> { where.not(longitude: nil, latitude: nil) }
  end

  def somewhere?
    location != "Anywhere"
  end

  protected

  def needs_geocoding?
    somewhere? && (location_changed? || new_record?)
  end
end

module Mappable
  extend ActiveSupport::Concern

  included do
    geocoded_by :location
    after_validation :geocode, if: :location_changed?
  end

  def latlng
    [latitude, longitude]
  end

  def to_marker
    identifier = if respond_to? :title
                   :title
                 elsif respond_to? :name
                   :name
                 else
                   raise "wtf!?"
                 end
    { latlng: latlng, popup: send(identifier) }
  end
end

# Air Quality Index Warning
class AQIWarning < ApplicationRecord
  validates_presence_of :user, :threshold, :longitude, :latitude, :location

  validates :threshold, numericality: { greater_than: 0 }

  belongs_to :user

  def as_json(options={})
    {
      id: self.id,
      latitude: self.latitude,
      longitude: self.longitude,
      location: self.location,
      threshold: self.threshold,
    }
  end
end

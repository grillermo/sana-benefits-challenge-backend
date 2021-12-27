# Air Quality Index Warning
class AQIWarning < ApplicationRecord
  validates_presence_of :user, :threshold, :longitude, :latitude, :location

  validates :threshold, numericality: { greater_than: 0 }

  belongs_to :user
end

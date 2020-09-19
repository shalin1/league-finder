class League < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :latitude, presence: true
  validates :longitude, presence: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
end

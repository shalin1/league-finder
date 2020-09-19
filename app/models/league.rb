class League < ApplicationRecord
  validates :name, presence: true, length: {maximum: 100}
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :latitude, presence: true, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
  validates :longitude, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}

  # the below little magic spell enables us to use
  # League.near([lat,long],disttance)
  # as part of the Geocoder library
  #
  # See https://www.rubydoc.info/gems/geocoder/frames#geospatial-database-queries for more details
  reverse_geocoded_by :latitude, :longitude
end

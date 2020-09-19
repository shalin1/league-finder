class League < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :latitude, presence: true
  validates :longitude, presence: true

  # this little magic spell enables us to use
  # League.near([lat,long],disttance)
  # as part of the Geocoder library
  #
  # See https://www.rubydoc.info/gems/geocoder/frames#geospatial-database-queries for more details
  reverse_geocoded_by :latitude, :longitude
end

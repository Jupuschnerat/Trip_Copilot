class Location < ApplicationRecord
  has_many :cities

  validates :iata, presence: true, uniqueness: true
  validates :icao, presence: true, uniqueness: true
  validates :country_code, presence: true
  validates :airport, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :region_name, presence: true

  def country_code(value)
    # Implementation for setting the country_code attribute
    self[:country_code] = value
  end
end

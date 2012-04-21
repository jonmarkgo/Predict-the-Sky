class Subscriber < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :phonenumber
  has_and_belongs_to_many :events
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address
end

class Subscriber < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :phonenumber
  has_and_belongs_to_many :events
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  validates :phonenumber, :uniqueness => true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 12012000000, :less_than_or_equal_to => 19999999999}

end

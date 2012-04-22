class Subscriber < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :phonenumber

  validates :phonenumber, :uniqueness => true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 12012000000, :less_than_or_equal_to => 19999999999}
  validates :latitude, :presence => true
  validates :longitude, :presence => true
  def self.within(latitude, longitude)
    Subscriber.near([latitude, longitude], 50)
  end
end

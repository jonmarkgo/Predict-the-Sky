class Subscriber < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :phonenumber
  has_and_belongs_to_many :events
end

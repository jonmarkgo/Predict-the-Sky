class Event < ActiveRecord::Base
  attr_accessible :name, :type
  has_and_belongs_to_many :subscribers


end

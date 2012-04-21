class Event < ActiveRecord::Base
  attr_accessible :name, :type
  has_and_belongs_to_many :subscribers

  def self.descendants
    ObjectSpace.each_object(::Class).select {|klass| klass < self }
  end

end

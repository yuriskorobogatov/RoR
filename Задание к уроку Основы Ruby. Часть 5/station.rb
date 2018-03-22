require_relative 'modules'

class Station
  attr_reader :name, :trains
  include InstanceCounter
  @@stations =[]


  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    p register_instance
  end

  def add_train(train)
    trains << train
  end

  def depart_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select{|train|  train.type == type}
  end

  def self.all
    p @@stations
  end
end
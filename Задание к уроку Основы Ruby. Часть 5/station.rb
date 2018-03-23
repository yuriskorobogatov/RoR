require_relative 'InstanceCounter'

class Station
  attr_reader :name, :trains
  include InstanceCounter
  @@stations =[]


  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
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
    @@stations
  end
end
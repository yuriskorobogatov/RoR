require_relative 'instance_counter'

class Station
  attr_reader :trains, :name
  include InstanceCounter
  @@stations =[]


  def initialize(name)
    @name = name
    @trains = []
    validation!
    @@stations << self
    register_instance
  end

  def validation!
    raise "Название станции должно состоять минимум из трех символов!" if name.length < 3
    true
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
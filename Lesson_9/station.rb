# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  attr_reader :trains, :name, :train
  include InstanceCounter

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @stations = []
    @stations << self
    register_instance
  end

  def validate!
    raise 'Название станции должно состоять минимум из трех символов!' if name.length < 3
    @trains.each do |train|
      raise 'Введенный объект не является объктом класса Station' unless train.is_a? Train
    end
    true
  end

  def add_train(train)
    @train = train
    trains << train
  end

  def depart_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def self.all
    @stations
  end

  def each_train
    @trains.each { |train| yield train }
  end
end

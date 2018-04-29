# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'company'
require_relative 'validation'

class Train
  attr_reader :speed, :number, :wagons, :route
  include Company
  include InstanceCounter

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @station_index = 0
    validate!
    register_instance
  end

  def accelerate
    @speed += 1
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && type == wagon.type
  end

  def remove_wagons
    return @wagons.pop if @speed.zero? && @wagons.length.positive?
    raise 'Ошибка отцепки! Либо поезд не остановлен, либо у него нет вагонов!'
  end

  def assign_route(route)
    @route = route
    @station_index = 0
    current_station.add_train(self)
  end

  def assign_route?
    route.nil?
  end

  def current_station
    @route.stations[@station_index]
  end

  def move_back
    return raise 'Поезд находится на первой станции!' if first_station?
    current_station.depart_train(self)
    @station_index -= 1
    current_station.add_train(self)
  end

  def move_next
    return raise 'Поезд находится на конечной станции!' if last_station?
    current_station.depart_train(self)
    @station_index += 1
    current_station.add_train(self)
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def prev_station
    @route.stations[@station_index - 1] if @station_index.positive?
  end

  def show_wagons
    @wagons.each { |wagon| yield wagon }
  end

  protected

  def last_station?
    current_station == @route.stations[-1]
  end

  def first_station?
    current_station == @route.stations[0]
  end
end

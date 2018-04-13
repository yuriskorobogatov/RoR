# frozen_string_literal: true

require_relative 'instance_counter'

class Route
  attr_reader :stations, :name
  include InstanceCounter

  def initialize(name, first_station, last_station)
    @name = name
    @stations = [first_station, last_station]
    register_instance
    validate!
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) if station != @stations[0] && station != @stations[-1]
  end

  def validate!
    raise 'Длина маршрута не может быть менее 6 символов' if @name.length < 6
    @stations.each do |station|
      raise 'Объект не является объктом класса Station' unless station.is_a? Station
    end
    true
  end
end

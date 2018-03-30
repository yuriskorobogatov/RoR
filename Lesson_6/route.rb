require_relative 'instance_counter'

class Route
  attr_reader :stations, :name
  include InstanceCounter

  def initialize(name, first_station, last_station)
    @name = name
    @stations = [first_station, last_station]
    register_instance
    validation!
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) if station != @stations[0] && station != @stations[-1]
  end

  def validation!
    raise "Название маршрута должно быть не менее шести символов" if @name.length < 6
    true
  end
end
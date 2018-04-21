# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Route
  attr_reader :stations, :name
  include InstanceCounter
  include Validation

  NAME_FORMAT = /.{6,}/i

  validate :name, :presence
  validate :name, :format, NAME_FORMAT
  validate :name, :type, String

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
end

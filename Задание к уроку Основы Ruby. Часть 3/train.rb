class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def depart_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train|  train.type == type }
  end
end

class Route
  attr_accessor :stations

  def initialize (first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station (station)
    @stations.insert(-2, station)
  end

  def delete_station (station)
    @stations.delete(station) if station != @stations[0] && station != @stations[-1]
  end
end

class Train
  attr_accessor  :number_wagons, :speed, :type

  def initialize(number, type, number_wagons)
    @number = number
    @speed = 0
    @type =  type
    @number_wagons = number_wagons
    @station_index = 0
  end

  def accelerate
    @speed += 1
  end

  def stop
    @speed = 0
  end

  def add_wagons
    @number_wagons += 1 if @speed == 0
  end

  def remove_wagons
    @number_wagons -= 1 if @speed == 0 && @number_wagons > 0
  end

  def assign_route(route)
    @route = route
    @station_index = 0
    current_station.add_train(self)
  end

  def move_back
    return unless prev_station?
    current_station.depart_train(self)
    @station_index -= 1
    current_station.add_train(self)
  end

  def move_next
    return unless next_station?
    current_station.depart_train(self)
    @station_index += 1
    current_station.add_train(self)
  end

  def next_station?
    @station_index < @route.station.length
  end

  def prev_station?
    @station_index > 0
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def current_station
    @route.stations[@station_index]
  end

  def prev_station
    @route.stations[@station_index - 1] if @station_index > 0
  end
end

st1 = Station.new('Москва')
st2 = Station.new('Пермь')
route = Route.new(st1, st2)
train = Train.new(1, :passenger, 10)
train.assign_route(route)
puts train.prev_station
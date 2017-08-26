class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type
    trains.select{|k| k.type}
  end


  def depart_train(train)
    trains.delete(train)
  end
end

class Route
  attr_accessor :first_station, :lats_station
  attr_reader :stations

  def initialize(first_station,lats_station)
    @stations = [first_station, lats_station]
      end

  def add_station(new_station)
    @stations << new_station
  end

  def delete_station(new_station)
    @stations.delete(new_station)
  end
end


class Train
  attr_accessor :number_wagons, :speed

  def initialize(number, type, number_wagons)
    @number = number
    @speed = 0
    @type = type
    @number_wagons = number_wagons.to_i
  end

  def accelerate
    @speed += 1
  end

  def stop
    @speed = 0
  end

  def current_station
    station(@station_index)
  end

  def assign_route(route)
    @route = route
    @route.current_station.add_train(self)
    @station_index = 0
  end

  def add_train(n)
    @number_wagons = @number_wagons + n if speed==0
  end

  def remove_train(n)
    @number_wagons = @number_wagons - n if speed==0
  end

  def next_station?
    @station_index < @route.station.length
  end

  def prev_station?
    @station_index > 0
  end

  def move_back
    return unless prev_station?
    current_station.remove_train(self)
    @station_index -= 1
    current_station.add_train(self)
  end

  def move_next
    return unless next_station?
    current_station.remove_train(self)
    @station_index += 1
    current_station.add_train(self)
  end

  
  def next_station
    @route.station[@station_index + 1]
  end

  def prev_station
    @route.station[@station_index - 1] if @station_index > 0
  end

  def station(index)
    @route.station[index]
  end
end
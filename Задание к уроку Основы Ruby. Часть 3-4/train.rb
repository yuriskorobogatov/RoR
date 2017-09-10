class Train
  attr_reader :speed, :type, :number
  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @station_index = 0
  end

  def accelerate
    @speed += 1
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && self.type == wagon.type
  end

  def remove_wagons
    @wagons.pop if @speed.zero?
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

  def next_station
    @route.stations[@station_index + 1]
  end

  def current_station
    @route.stations[@station_index]
  end

  def prev_station
    @route.stations[@station_index - 1] if @station_index > 0
  end

  protected
    #Выделил эти методы по принципу:
    #Пользователь не должен менять маршрут следующей или предидущей станции, да бы не ненарушить  построеный маршрут.
    #Знать текущую станцию не обязательно для передвижения поезда по маршруту
    #Так посоветовал куратор
  def next_station?
    if stations.size>0
    @station_index < @route.station.length
    else puts "Станция не создана, сперва создайте станцию!"
    return start
    end
  end

  def prev_station?
    @station_index > 0
  end

end


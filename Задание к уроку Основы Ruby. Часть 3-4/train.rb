
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
    if @speed.zero? && @wagons.length>0
      @wagons.pop
    else
      puts "Ошибка отцепки! Либо поезд не остановлен, либо у него нет вагонов!"
    end
  end

  def assign_route(route)
    @route = route
    @station_index = 0
    current_station.add_train(self)
  end

  def move_back
    if first_station? == true
      puts "Поезд находится на первой станции и назад ехать не может!"
    end
    return if first_station?
    current_station.depart_train(self)
    @station_index -= 1
    current_station.add_train(self)
  end

  def move_next
    if last_station? == true
      puts "Поезд находится на конечной станции и вперед не поедет!"
    end
    return if last_station?
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

  def last_station?
    current_station == @route.stations[-1]
   end

  def first_station?
    current_station == @route.stations[0]
  end

end

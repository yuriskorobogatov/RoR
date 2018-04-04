require_relative 'instance_counter'
require_relative 'company'

class Train
  attr_reader :speed, :type, :number
  include Company
  include InstanceCounter
  @@trains = []
  NUMBER_FORMAT = /^(\d|[a-z]){3}-?(\d|[a-z]){2}$/i

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @station_index = 0
    validation!
    @@trains << self
    register_instance
  end

  def validation!
    raise "Введите номер поезда в правильном формате!!" if @number !~ NUMBER_FORMAT
    raise "Скорость не может быть отрицательной" if @speed < 0
    true
  end

  def route_valid!
    raise "Данный объект не пренадлежит классу Route" if @route.class != Route
    raise "Номер текущей станции превышает длину маршрута" if @station_index +1 > @route.stations.length
  end

  def wag_valid!
    raise "Скорость не нулевая" unless @speed.zero?
    raise "Не соответствие типов вагона и поезда" unless self.type == wagon.type
  end

  def accelerate
    @speed += 1
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    wag_valid!
    @wagons << wagon
  end

  def remove_wagons
    if @speed.zero? && @wagons.length > 0
      @wagons.pop
    else
      puts "Ошибка отцепки! Либо поезд не остановлен, либо у него нет вагонов!"
      return
    end
  end

  def assign_route(route)
    @route = route
    route_valid!
    @station_index = 0
    current_station.add_train(self)
  end

  def move_back
    if first_station?
      puts "Поезд находится на первой станции и назад ехать не может!"
      return
    else
      current_station.depart_train(self)
      @station_index -= 1
      current_station.add_train(self)
    end
  end

  def move_next
    if last_station?
      puts "Поезд находится на конечной станции и вперед не поедет!"
      return
    else
      current_station.depart_train(self)
      @station_index += 1
      current_station.add_train(self)
    end
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

  def self.find(number)
     p @@trains.find{|train| train.number == number}
     return
  end

  protected

  def last_station?
    current_station == @route.stations[-1]
  end

  def first_station?
    current_station == @route.stations[0]
  end

end
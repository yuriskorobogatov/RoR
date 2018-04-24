# frozen_string_literal: true

require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'carriage.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passenger_carriage.rb'
require_relative 'company.rb'
require_relative 'validation'

class Main
  attr_reader :stations, :trains, :routes
  include Company
  include InstanceCounter
  include Validation
  extend Accessors

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start
    loop do
      puts '
================================================
        Выбирите действие:
        1  - Создать станцию
        2  - Создать поезд
        3  - Создать маршрут
        4  - Добавить станцию в маршрут
        5  - Удалить станцию из маршрута
        6  - Назначить маршрут поезду
        7  - Добавить вагон к поезду
        8  - Отцепить вагон от поезда
        9  - Переместить поезд вперед по маршруту
        10 - Переместить поезд назад по маршруту
        11 - Посмотреть список станций
        12 - Посмотреть список поездов на станции
        13 - Найти поезд по номеру
        14 - Занять 1 место в вагоне
        15 - Посмотреть список вагонов у поезда
        0  - Выход
================================================='
      action = gets.to_i
      break if action.zero?
      case action
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        add_station_to_route
      when 5
        del_station_from_route
      when 6
        assign_route_to_train
      when 7
        add_wagon_to_train
      when 8
        del_wagon_from_train
      when 9
        move_train_forward
      when 10
        move_train_backward
      when 11
        show_list_of_stations
      when 12
        show_list_of_trains_on_station
      when 13
        find_train
      when 14
        take_seat_or_volume
      when 15
        show_train_wagons
      else
        puts 'Введите число от 0 до 15'
      end
    end
  end

  protected

  def create_station
    puts 'Введите название станции:'
    name = gets.chomp
    if @stations.find { |station| station.name == name }
      puts 'Станция с таким именем уже существует'
      return
    else
      station = Station.new(name)
      @stations << station
    end
  rescue RuntimeError => e
    puts e.message
    return
  end

  def choose_station
    puts 'Введите название станции из предложенных ниже:'
    @stations.each { |stantion| puts stantion.name }
    name = gets.chomp
    unless @stations.find { |station| station.name == name }
      puts 'Такой станции не существует'
      return
    end
    @stations.find { |station| station.name == name }
  end

  def create_train
    puts 'Введите тип поезда:
    1 - Пассажирский
    2 - Грузовой'
    type = gets.to_i
    if type == 1
      create_passenger_train
    elsif type == 2
      create_cargo_train
    else
      puts 'Введите 1 или 2'
    end
  end

  def create_passenger_train
    puts 'Введите номер поезда:'
    number = gets.chomp
    if @trains.find { |train| train.number == number }
      puts 'Поезд с таким номером уже существует'
      return
    else
      train = PassengerTrain.new(number)
      @trains << train
    end
  rescue RuntimeError => e
    puts e.message
    return
  end

  def create_cargo_train
    puts 'Введите номер поезда:'
    number = gets.chomp
    if @trains.find { |train| train.number == number }
      puts 'Поезд с таким номером уже существует'
      return
    else
      train = CargoTrain.new(number)
      @trains << train
    end
  rescue RuntimeError => e
    puts e.message
    return
  end

  def input_number_of_train
    puts 'введите номер поезда:'
    @trains.each { |train| puts train.number }
    gets.chomp
  end

  def choose_train
    print 'Из списка, представленного ниже, '
    number = input_number_of_train
    unless @trains.find { |train| train.number == number }
      puts 'Поезда с таким номером не существует'
      return
    end
    @trains.find { |train| train.number == number }
  end

  def create_route
    puts 'Введите название маршрута:'
    name = gets.chomp
    if @routes.find { |route| route.name == name }
      puts 'Маршрут с таким названием уже существует, введите другое название маршрута'
      return
    else
      puts 'Начальная станция: '
      first_station = choose_station
      return unless @stations.find { |station1| station1 == first_station }
      puts 'Конечная станция: '
      last_station = choose_station
      return unless @stations.find { |station1| station1 == last_station }
      route = Route.new(name, first_station, last_station)
      @routes << route
    end
  rescue RuntimeError => e
    puts e.message
    return
  end

  def choose_route
    puts 'Введите название маршрута из предложенных ниже: '
    @routes.each { |route| puts route.name }
    name = gets.chomp
    unless @routes.find { |route| route.name == name }
      puts 'Такого маршрута не существует.'
      return
    end
    @routes.find { |route| route.name == name }
  end

  def add_station_to_route
    if station_and_route?
      station = choose_station
      return unless @stations.find { |station1| station1 == station }
      route = choose_route
      return unless @routes.find { |route1| route1 == route }
    else
      puts 'Станции или маршрута не существует.'
      return
    end
    if route.stations.find { |station1| station1.name == station.name }
      puts 'Данная станция уже существует в маршруте, повторное добавление запрещено'
    else
      route.add_station(station)
    end
  end

  def del_station_from_route
    if station_and_route?
      station = choose_station
      return unless @stations.find { |station1| station1 == station }
      route = choose_route
      return unless @routes.find { |route1| route1 == route }
      route.delete_station(station)
    else
      puts 'Станции или маршрута не существует.'
      nil
    end
  end

  def assign_route_to_train
    if train?
      train = choose_train
      return unless @trains.find { |train1| train1 == train }
      route = choose_route
      return unless @routes.find { |route1| route1 == route }
      train.assign_route(route)
    else
      puts 'Поезд не существует'
      return
    end
  rescue RuntimeError => e
    puts e.message
    return
  end

  def create_passenger_wagons
    puts 'Введите количество пассажирских мест в вагоне:'
    seats_sum = gets.chomp
    PassengerCarriage.new(seats_sum)
  end

  def create_cargo_wagons
    puts 'Введите количество  грузомест в вагоне:'
    sum_capacity = gets.chomp
    CargoCarriage.new(sum_capacity)
  end

  def add_wagon_to_train
    if train?
      train = choose_train
      return unless @trains.find { |train1| train1 == train }
      wagon = create_passenger_wagons if train.is_a? PassengerTrain
      wagon = create_cargo_wagons if train.is_a? CargoTrain
      wagon.company
      train.add_wagon(wagon)
    else
      puts 'Поезд не существует'
      return
    end
  rescue RuntimeError => e
    puts e.message
    return
  end

  def del_wagon_from_train
    if train?
      train = choose_train
      return unless @trains.find { |train1| train1 == train }
      train.remove_wagons
    else
      puts 'Поезд не существует'
      return
    end
  rescue RuntimeError => e
    puts e.message
  end

  def move_train_forward
    if train?
      train = choose_train
      return unless @trains.find { |train1| train1 == train }
      if train.assign_route?
        puts 'Поезду не присвоен маршрут! Для начала создайте маршрут и присвойте его поезду!'
        return
      end
      train.move_next
    else
      puts 'Поезд не существует'
      return
    end
  rescue RuntimeError => e
    puts e.message
  end

  def move_train_backward
    if train?
      train = choose_train
      return unless @trains.find { |train1| train1 == train }
      if train.assign_route?
        puts 'Поезду не присвоен маршрут! Для начала создайте маршрут и присвойте его поезду!'
        return
      end
      train.move_back
    else
      puts 'Поезд не существует'
      return
    end
  rescue RuntimeError => e
    puts e.message
  end

  def take_seat_or_volume
    puts 'Выберете поезд:'
    if train?
      train = choose_train
      return unless @trains.find { |train1| train1 == train }
    else
      puts 'Поезд не существует'
      return
    end
    if train.wagons.empty?
      puts 'У поезда нет вагонов!'
      return
    end
    return train.wagons[-1].take_a_seat if train.class == PassengerTrain
    train.wagons[-1].take_a_capacity
  rescue RuntimeError => e
    puts e.message
  end

  def show_list_of_stations
    @stations.each { |station| puts station.name }
  end

  def show_list_of_trains_on_station
    station = choose_station
    return unless @stations.find { |station1| station1 == station }
    station.each_train { |train| puts "Поезд: #{train.inspect}" }
  end

  def show_train_wagons
    train = choose_train
    return unless @trains.find { |train1| train1 == train }
    train.show_wagons { |wagon| puts "Вагон: #{wagon.inspect}" }
  end

  def find_train
    puts 'Введите номер искомого поезда:'
    number = gets.chomp
    find_train = @trains.find { |train| train.number == number }
    p find_train
  end

  def show_company
    p choose_train.company
  end

  def station_and_route?
    !@stations.empty? && !@routes.empty?
  end

  def train?
    !@trains.empty?
  end
end

Main.new.start

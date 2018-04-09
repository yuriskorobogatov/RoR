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
  attr_reader :stations, :trains, :routes, :seats_sum
  include Company
  include InstanceCounter
  include Validation

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start
    loop do
      puts "
================================================
        Выберите действие:
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
================================================="

      action = gets.to_i

      break if action == 0

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
          puts "Введите число от 0 до 12"
      end
    end
  end

  protected
  #Все эти методы отнес в секцию protected чтоб с внешки можно было вызывать, только те методы, что указаны в
  # текстовом меню, т.е. для того, чтоб пользователь не мог менять параметры поездов, станций, маршрутов напрямую,
  # поскольку все методы связаны и прямое изменение метода(из логической цепочки), не вызовет предыдущие методы из
  # этой цепочки, соответственно нарушится логика программы.

  def create_station
    puts "Введите название станции: "
    name = gets.chomp
    if @stations.find{|station| station.name == name}
      puts "Станция с таким именем уже существует"
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
    puts "Введите название станции из предложенных ниже:"
    @stations.each{|stantion| puts stantion.name}
    name = gets.chomp
    unless @stations.find{|station| station.name == name}
      puts "Такой станции не существует"
      return
    end
    @stations.find{|station| station.name == name}
  end

  def create_train
    puts "Введите тип поезда:
    1 - Пассажирский
    2 - Грузовой"
    type = gets.to_i
    if type == 1
      create_passenger_train
    elsif type == 2
      create_cargo_train
    else
      puts "Введите 1 или 2"
      return
    end
  end

  def create_passenger_train
    puts "Введите номер поезда:"
    number = gets.chomp
     if @trains.find{|train| train.number == number}
       puts "Поезд с таким номером уже существует"
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
    puts "Введите номер поезда:"
    number = gets.chomp
    if @trains.find{|train| train.number == number}
      puts "Поезд с таким номером уже существует"
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
    puts "введите номер поезда:"
    @trains.each{|train| puts train.number}
    number = gets.chomp
  end

  def choose_train
    print "Из списка, представленного ниже, "
    number = input_number_of_train
      unless @trains.find{|train| train.number == number}
        puts "Поезда с таким номером не существует"
        return
      end
    @trains.find{|train| train.number == number}
  end

  def create_route
    puts "Введите название маршрута:"
    name = gets.chomp
    if @routes.find{|route| route.name == name}
      puts "Маршрут с таким названием уже существует, введите другое название маршрута"
      return
    else
      puts "Начальная станция: "
      first_station = choose_station
      unless @stations.find{|station1| station1 == first_station}
        return
      end
      puts "Конечная станция: "
      last_station = choose_station
      unless @stations.find{|station1| station1 == last_station}
        return
      end
      route = Route.new(name, first_station, last_station)
      @routes << route
    end
      rescue RuntimeError => e
        puts e.message
      return
  end

  def choose_route
    puts "Введите название маршрута из предложенных ниже: "
    @routes.each{|route| puts route.name}
    name = gets.chomp
    unless @routes.find{|route| route.name == name}
      puts "Такого маршрута не существует."
      return
    end
    @routes.find{|route| route.name == name}
  end

  def add_station_to_route
    unless station_and_route?
      puts "Станции или маршрута не существует."
      return
    else
    station = choose_station
    unless @stations.find{|station1| station1 == station}
      return
    end
    route = choose_route
    unless @routes.find{|route1| route1 == route}
      return
    end
    end
    if route.stations.find{|station1| station1.name == station.name}
      puts "Данная станция уже существует в маршруте, повторное добавление запрещено"
      return
    else
      route.add_station(station)
    end
  end

  def del_station_from_route
    unless station_and_route?
      puts "Станции или маршрута не существует."
      return
    else
      station = choose_station
      unless @stations.find{|station1| station1 == station}
        return
      end
      route = choose_route
      unless @routes.find{|route1| route1 == route}
        return
      end
      route.delete_station(station)
    end
  end

  def assign_route_to_train
    unless train?
      puts "Поезд не существует"
      return
    else
    train = choose_train
    unless @trains.find{|train1| train1 == train}
      return
    end
    route = choose_route
    unless @routes.find{|route1| route1 == route}
      return
    end
    train.assign_route(route)
    end
    rescue RuntimeError => e
      puts e.message
    return
  end

  def create_passenger_wagons
    puts "Введите количество пассажирских мест в вагоне:"
    seats_sum = gets.chomp.to_i
    wagons = PassengerCarriage.new(seats_sum)
  end

  def create_cargo_wagons
    puts "Введите количество  грузомест в вагоне:"
    sum_capacity = gets.chomp.to_i
    wagons = CargoCarriage.new(sum_capacity)
  end

  def add_wagon_to_train
    unless train?
      puts "Поезд не существует"
      return
    else
       train = choose_train
       unless @trains.find{|train1| train1 == train}
         return
       end
    if train.class == PassengerTrain
       wagon = create_passenger_wagons
       wagon.company
    else
       wagon = create_cargo_wagons
       wagon.company
    end
       train.add_wagon(wagon)
    end
    rescue RuntimeError => e
      puts e.message
      return
  end

  def del_wagon_from_train
    unless train?
      puts "Поезд не существует"
      return
    else
    train = choose_train
    unless @trains.find{|train1| train1 == train}
      return
    end
    train.remove_wagons
    end
  end

  def move_train_forward
    unless train?
      puts "Поезд не существует"
      return
    else
      train = choose_train
      unless @trains.find{|train1| train1 == train}
        return
      end
      if train.assign_route?
        puts "Поезду не присвоен маршрут! Для начала создайте маршрут и присвойте его поезду!"
        return
      end
      train.move_next
    end

  end

  def move_train_backward
    unless train?
      puts "Поезд не существует"
      return
    else
    train = choose_train
    unless @trains.find{|train1| train1 == train}
      return
    end
    if train.assign_route?
      puts "Поезду не присвоен маршрут! Для начала создайте маршрут и присвойте его поезду!"
      return
    end
    train.move_back
    end
  end

  def take_seat_or_volume
    puts "Выберете поезд:"
    unless train?
      puts "Поезд не существует"
      return
    else
      train = choose_train
      unless @trains.find{|train1| train1 == train}
        return
      end
    end
    if train.class == PassengerTrain
    train.wagons[-1].take_a_seat
    else
      train.wagons[-1].take_a_capacity
    end
  end

  def show_list_of_stations
    @stations.each{|station| puts station.name}
  end

  def show_list_of_trains_on_station
    station = choose_station
    unless @stations.find{|station1| station1 == station}
      return
    end
    station.each_train{|train| puts "Поезд: #{train.inspect}"}
  end

  def show_train_wagons
    train = choose_train
    unless @trains.find{|train1| train1 == train}
      return
    end
    train.show_wagons{|wagon| puts "Вагон: #{wagon.inspect}"}
  end

  def find_train
    puts "Введите номер искомого поезда:"
    number = gets.chomp
    Train.find(number)
  end

  def show_company
    p choose_train.company
  end

  def station_and_route?
    @stations.size > 0 && @routes.size > 0
  end

  def train?
    @trains.size > 0
  end
end

Main.new.start

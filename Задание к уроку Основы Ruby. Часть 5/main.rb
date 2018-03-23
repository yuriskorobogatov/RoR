require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'carriage.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passenger_carriage.rb'
require_relative 'AddCompany.rb'



class Main
  attr_reader :stations, :trains, :routes
  include AddCompany

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
        14 - Показать производителя поезда
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
          show_train

        when 14
          show_company

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
      puts "Создана станция #{station.inspect}"
    end
  end

  def choose_station
    puts "Введите название станции из предложенных ниже:"
    @stations.each{|stantion| puts stantion.name}
    name = gets.chomp
    unless @stations.find{|station| station.name == name}
      puts "Такой станции не существует"
      #если сюда поставлю просто return, то при неправильном вводе имени первой, либо второй станции, программа будет
      # подставлять nil
      # метод choose_station ни каких других методов не вызывает, по этому считаю, что его можно замкнуть на себя
      # пока этот метод не выполнится, другие не запускаюстя.
      choose_station
    end
    @stations.find{|station| station.name == name}
  end

  def create_train
    type = input_type_of_train
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
    add_company
    number = input_number_of_train
    p train = PassengerTrain.new(number, company)
    @trains << train
  end

  def create_cargo_train
    add_company
    number = input_number_of_train
    p train = CargoTrain.new(number, company)
    @trains << train
  end

  def input_number_of_train
    puts "введите номер поезда:"
    @trains.each{|train| puts train.number}
    number = gets.to_i
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

  def input_type_of_train
    puts "Введите тип поезда:
    1 - Пассажирский
    2 - Грузовой"
    type = gets.to_i
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
      puts "Конечная станция: "
      last_station = choose_station
      route = Route.new(name, first_station, last_station)
      @routes << route
      puts "Создан маршрут: #{route.inspect}"
    end
  end

  def choose_route
    puts "Введите название маршрута из предложенных ниже: "
    @routes.each{|route| puts route.name}
    name = gets.chomp
    unless @routes.find{|route| route.name == name}
      puts "Такого маршрута не существует"
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
    route = choose_route
    end
    if route.stations.find{|station1| station1.name == station.name}
      puts "Данная станция уже существует в маршруте, повторное добавление запрещено"
      return
    else
      route.add_station(station)
      p route
    end
  end

  def del_station_from_route
    unless station_and_route?
      puts "Станции или маршрута не существует."
      return
    else
      station = choose_station
      route = choose_route
      route.delete_station(station)
      p route
    end
  end

  def assign_route_to_train
    unless train?
      puts "Поезд не существует"
      return
    else
    train = choose_train
    route = choose_route
    p train.assign_route(route)
    end
  end

  def create_passenger_wagons
    add_company
    wagons = PassengerCarriage.new(company)
  end

  def create_cargo_wagons
    add_company
    wagons = CargoCarriage.new(company)
  end

  def add_wagon_to_train
    unless train?
      puts "Поезд не существует"
      return
    else
       train = choose_train
    if train.class == PassengerTrain
       wagon = create_passenger_wagons
       p wagon.company
    else
       wagon = create_cargo_wagons
       p wagon.company
    end
       train.add_wagon(wagon)
       p train
    end
  end

  def del_wagon_from_train
    unless train?
      puts "Поезд не существует"
      return
    else
    train = choose_train
    train.remove_wagons
    end
  end

  def move_train_forward
    unless train?
      puts "Поезд не существует"
      return
    else
      train = choose_train
      train.move_next
    end

  end

  def move_train_backward
    unless train?
      puts "Поезд не существует"
      return
    else
    train = choose_train
    train.move_back
    end
  end

  def show_list_of_stations
    @stations.each{|station| puts station.name}
  end

  def show_list_of_trains_on_station
    station = choose_station
    puts station.trains
  end

  def show_train
    puts "Введите номер искомого поезда:"
    number = gets.chomp.to_i
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

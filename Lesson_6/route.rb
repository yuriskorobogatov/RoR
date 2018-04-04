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
    # проверка что все станции это объекты класса Station, но как это проверить(сгенерировать ошибку), если механизм
    # выбора станции предусматривает выбор станции из списка станций (объектов класса Station)
    raise "Введенный объект не является объктом класса Station"   unless @stations.each {|station| station.class == Station}
    raise "Название маршрута должно быть не менее шести символов" if @name.length < 6
    true
  end
end
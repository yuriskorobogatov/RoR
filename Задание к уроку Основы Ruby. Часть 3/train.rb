class Station
  attr_accessor :name, :trains, :pas, :wei
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def count_pas
    @pas = []
    trains.each { |k| pas.push(k) if k.type == 'passenger' }
  end

  def count_wei
    @wei = []
    trains.each { |k| wei.push(k) if k.type == 'freight' }
  end

  def depart_train(train)
    trains.delete(train)
  end
end

class Route
  attr_accessor :first_st, :lats_st, :else_st
  def initialize(first_st,lats_st)
    @first_st = first_st
    @lats_st = lats_st
    @else_st = []
  end
  def add_st(new_st)
    @else_st << new_st
  end
  def delete_st(new_st)
    else_st.delete(new_st)
  end
  def show_st
    puts "#{@first_st}" + else_st.each {|k| puts k} + "#{@lats_st}"
  end
end


class Train
  attr_accessor :v_count, :speed
  def initialize(number, type, v_count)
    @number = number
    @speed = 0
    @type = type
    @v_count = v_count.to_i
  end

  def accelerate_by
    @speed += 1
  end
  def stop
    @speed = 0
  end

  def assign_route(route)
    @route = route
    @route.first_st.add_st(self)
    @station_index = 0
  end

  def current_station
    @route.else_st[@station_index] if @route
  end

  def add_v(n)
    @v_count = @v_count.to_i + n.to_i if speed==0
  end
  def remove_v(n)
    @v_count = @v_count.to_i - n.to_i if speed==0
  end

  def next_st?
    @station_index < @route.else_st.length
  end

  def prev_st?
    @station_index > 0
  end

  def move_back
    return unless prev_st?
    current_station.delete_st(self)
    @station_index -= 1
    current_station.add_st(self)
  end

  def move_next
    return unless next_st?
    current_station.delete_st(self)
    @station_index += 1
    current_station.add_st(self)
  end

  def next_st
    @route.else_st[@station_index + 1]
  end

  def prev_st
    @route.else_st[@station_index - 1] if @station_index > 0
  end


end
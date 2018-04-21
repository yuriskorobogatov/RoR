class PassengerCarriage < Carriage

  attr_reader :seats_sum, :seats


  def initialize(seats_sum)
    @type = :passenger
    @seats_sum = seats_sum
    @seats = seats_sum
  end

  def take_a_seat
    if @seats_sum == 0
      raise "Уже все места заняты, больше мест нет!!!"
      return
    else
      @seats_sum -= 1
    end
  end

  def show_free_seats
  @seats_sum
  end

  def show_busy_seats
      @seats - @seats_sum
  end

end
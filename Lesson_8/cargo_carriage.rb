class CargoCarriage < Carriage

  attr_reader :sum_capacity, :first_capacity

  def initialize(sum_capacity)
    @type = :cargo
    @sum_capacity = sum_capacity
    @first_capacity =sum_capacity
  end

  def take_a_capacity
    if @sum_capacity == 0
      raise "Уже всё место занято, больше места нет!!!"
      return
    else
      @sum_capacity -= 1
    end
  end

  def show_free_capacity
    @sum_capacity
  end

  def show_busy_capacity
    @first_capacity - @sum_capacity
  end
end
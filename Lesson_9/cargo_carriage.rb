# frozen_string_literal: true

class CargoCarriage < Carriage
  attr_reader :sum_capacity, :first_capacity, :type

  def initialize(sum_capacity)
    @type = :cargo
    @sum_capacity = sum_capacity
    @first_capacity = sum_capacity
  end

  def take_a_capacity
    return raise 'Already the whole place is occupied!' if @sum_capacity.zero?
    @sum_capacity -= 1
  end

  def show_free_capacity
    @sum_capacity
  end

  def show_busy_capacity
    @first_capacity - @sum_capacity
  end
end

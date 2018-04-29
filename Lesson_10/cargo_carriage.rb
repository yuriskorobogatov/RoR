# frozen_string_literal: true

require_relative 'validation'

class CargoCarriage < Carriage
  attr_reader :sum_capacity, :first_capacity, :type

  include Validation

  validate :sum_capacity, :validate_presence
  validate :sum_capacity, :validate_type, Integer

  def initialize(sum_capacity)
    @type = :cargo
    @sum_capacity = sum_capacity
    @first_capacity = sum_capacity
    validate!
  end

  def take_a_capacity
    return raise 'Уже все места заняты!' if @sum_capacity.zero?
    @sum_capacity -= 1
  end

  def show_free_capacity
    @sum_capacity
  end

  def show_busy_capacity
    @first_capacity - @sum_capacity
  end
end

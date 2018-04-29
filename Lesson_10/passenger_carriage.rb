# frozen_string_literal: true

require_relative 'validation'

class PassengerCarriage < Carriage
  attr_reader :seats_sum, :seats, :type

  include Validation

  validate :seats_sum, :validate_presence
  validate :seats_sum, :validate_type, Integer

  def initialize(seats_sum)
    @type = :passenger
    @seats_sum = seats_sum
    @seats = seats_sum
    validate!
  end

  def take_a_seat
    return raise 'Уже все места заняты, больше мест нет!!!' if @seats_sum.zero?
    @seats_sum -= 1
  end

  def show_free_seats
    @seats_sum
  end

  def show_busy_seats
    @seats - @seats_sum
  end
end

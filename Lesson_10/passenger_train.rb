# frozen_string_literal: true

require_relative 'validation'

class PassengerTrain < Train
  attr_reader :type
  include Validation

  NUMBER_FORMAT = /^(\d|[a-z]){3}-?(\d|[a-z]){2}$/i

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    @type = :passenger
    super
  end
end

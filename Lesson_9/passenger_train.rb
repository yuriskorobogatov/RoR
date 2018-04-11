# frozen_string_literal: true

class PassengerTrain < Train
  attr_reader :type
  def initialize(number)
    @type = :passenger
    super
  end
end

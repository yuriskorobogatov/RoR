class PassengerTrain < Train
  def initialize(number, company)
    @type = :passenger
    super
  end
end
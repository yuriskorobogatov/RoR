class PassengerCarriage < Carriage
  def initialize(company)
    @type = :passenger
    super
  end
end
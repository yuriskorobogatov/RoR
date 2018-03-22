class CargoTrain < Train
  def initialize(number, company)
    @type = :cargo
    super
  end
end
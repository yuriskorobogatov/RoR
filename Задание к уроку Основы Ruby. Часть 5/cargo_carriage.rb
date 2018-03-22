class CargoCarriage < Carriage
  def initialize(company)
    @type = :cargo
    super
  end
end
require_relative 'AddCompany'

class Carriage
  attr_reader :type
  include AddCompany
  def initialize(company)
    @company = company
  end
end
require_relative 'modules'

class Carriage
  attr_reader :type
  include AddCompany
  def initialize(company)
    @company = company
  end
end
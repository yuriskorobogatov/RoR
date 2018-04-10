require_relative 'company'

class Carriage
  attr_reader :type
  include Company
end
# frozen_string_literal: true

require_relative 'acessors'

class Test
  extend Accessors

  attr_accessor_with_history :one, :two, :three
  strong_attr_accessor :name, String
end

test = Test.new

test.one = 123
test.one = ['testing', 12, 13]
test.one = 'string'

test.two = 'steam'
test.two = 12_345

p test.name = 'tasdf'

p test.one_history
p test.two_history

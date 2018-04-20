# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'acessors'

class Station
  attr_reader :train
  include InstanceCounter
  include Validation
  extend Accessors

  VALID_NAME = /.{3,}/i

  validate :name, :presence
  validate :name, :format, VALID_NAME
  validate :name, :type, String

   strong_attr_accessor :trains, Array
   attr_accessor_with_history :name

  def initialize(name)
    @name = name.to_s
    @trains = []
    validate!
    @stations = []
    @stations << self
    register_instance
  end

  def add_train(train)
    @train = train
    trains << train
  end

  def depart_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def self.all
    @stations
  end

  def each_train
    @trains.each { |train| yield train }
  end
end


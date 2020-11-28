require_relative 'modules'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name
  attr_accessor :trains

  validate :name, :presence
  validate :name, :type, String

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def enum_trains(&block)
    raise LocalJumpError, 'no block' unless block_given?
    return p 'The station has no trains' if trains == []

    trains.each { |train| block.call(train) }
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train) if @trains.include?(train)
  end

  def trains_by_type(type)
    trains.each { |train| p train if train.class.to_s == type }
  end

  def self.all
    @@stations.each { |station| p station }
  end
end

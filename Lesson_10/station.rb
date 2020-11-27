require_relative 'modules'

class Station
  include InstanceCounter

  attr_reader :name
  attr_accessor :trains

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def enum_trains(&block)
    raise LocalJumpError, 'no block' unless block_given?
    return p 'The station has no trains' if trains == []

    trains.each { |train| block.call(train) }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
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

  protected

  def validate!
    raise TypeError, 'Invalid station name type' unless name.is_a?(String)
  end
end

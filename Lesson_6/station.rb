require_relative 'modules.rb'

class Station
  include InstanceCounter

  attr_reader :name
  attr_accessor :trains

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def take_train(train)
    self.trains << train
  end

  def send_train(train)
    self.trains.delete(train) if @trains.include?(train)
  end

  def trains_by_type(type)
    trains.each{|train| p train if train.class.to_s == type}
  end

  def self.all
    @@stations.each{|station| p station}
  end
end

require_relative 'modules'

class Train
  include ManufacturerCompany
  include InstanceCounter

  @@trains = {}

  attr_accessor :type, :current_speed, :wagons
  attr_reader :number, :current_station

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @current_speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def enum_wagons(&block)
    raise LocalJumpError, 'no block' unless block_given?
    return p 'The train has no wagons' if wagons == []

    wagons.each { |wagon| block.call(wagon) }
  end

  def speed_up(speed)
    self.current_speed = speed
  end

  def brake
    self.current_speed = 0
  end

  def assign_route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.take_train(self)
  end

  def move_forward
    raise 'У поезда не установлен маршрут' unless route_set?

    return unless @current_station != @route.stations.last

    @current_station.send_train(self) if @current_station.trains.include?(self)
    @current_station = @route.stations[@route.stations.index(@current_station) + 1]
    @current_station.take_train(self)
  end

  def move_back
    raise 'У поезда не установлен маршрут' unless route_set?

    return unless @current_station != @route.stations.first

    @current_station.send_train(self) if @current_station.trains.include?(self)
    @current_station = @route.stations[@route.stations.index(@current_station) - 1]
    @current_station.take_train(self)
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if route_set?
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] if route_set?
  end

  def add_wagon(wagon)
    return if train_move? || wagon.is_coupled
    return unless wagon.type == type

    wagon.is_coupled = true
    wagons << wagon
  end

  def remove_wagons(wagon)
    return unless !train_move? || wagons.include?(wagon)

    wagon.is_coupled = false
    wagons.delete(wagon)
  end

  def self.find(number)
    @@trains[number]
  end

  protected

  def validate!
    raise 'Wrong type of train' unless type == :cargo || type == :passenger
    raise 'Wrong number of train' if (number =~ /^(\d{3}|\w{3})-*(\d{3}|\w{3})$/).nil?
  end

  private

  def route_set?
    @route != nil
  end

  def train_move?
    current_speed != 0
  end
end

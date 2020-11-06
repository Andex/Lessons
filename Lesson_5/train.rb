class Train
  attr_accessor :current_speed, :wagons
  attr_reader :number, :current_station

  def initialize(number)
    @number = number
    @wagons = []
    @current_speed = 0
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
    return "У поезда не установлен маршрут" unless is_route_set?
    if @current_station != @route.stations.last
      @current_station.send_train(self) if @current_station.trains.include?(self)
      @current_station = @route.stations[@route.stations.index(@current_station) + 1]
      @current_station.take_train(self)
    end
  end
  
  def move_back
    return "У поезда не установлен маршрут" unless is_route_set?
    if @current_station != @route.stations.first
      @current_station.send_train(self) if @current_station.trains.include?(self)
      @current_station = @route.stations[@route.stations.index(@current_station) - 1]
      @current_station.take_train(self)
    end
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if is_route_set?
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] if is_route_set?
  end

  def remove_wagons(wagon)
    if current_speed == 0 || wagons.include?(wagon)
      wagon.is_coupled = false
      wagons.delete(wagon)
    end
  end

  private
  
  # это вспомогательный  метод для разрешения перемещения поезда по маршруту, поэтому его можно убрать из интерфейса
  # не в protected потому что незачем переопределять данный метод т.к. маршрут поезду либо назначен, либо нет
  def is_route_set?
    @route != nil
  end

end
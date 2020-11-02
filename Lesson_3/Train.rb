# Класс Train (Поезд):
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
#   Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route). 
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  attr_accessor :current_speed
  attr_reader :number, :type, :quantity_railway_car, :current_station

  def initialize(number, type, quantity_railway_car)
    @number = number
    @type = type
    @quantity_railway_car = quantity_railway_car
    @current_speed = 0
    @current_station = nil
    @route = nil
  end

  def speed_up(speed)
    self.current_speed = speed
  end

  def brake
    self.current_speed = 0
  end

  def add_railway_cars
    if current_speed == 0
      @quantity_railway_car += 1
    else
      p "Error. Можно прицеплять вагон только когда поезд не движется!"
    end
  end

  def remove_railway_cars
    if current_speed == 0 || @quantity_railway_car > 0
      @quantity_railway_car -= 1
    else
      p "Error. Можно отцеплять вагон только когда поезд не движется и когда есть что отцеплять!"
    end
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
    else
      p 'Поезд не может двигаться вперед т.к. стоит на конечной станции'
    end
  end
  
  def move_back
    return "У поезда не установлен маршрут" unless is_route_set?
    if @current_station != @route.stations.first
      @current_station.send_train(self) if @current_station.trains.include?(self)
      @current_station = @route.stations[@route.stations.index(@current_station) - 1]
      @current_station.take_train(self)
    else
      p 'Поезд не может двигаться назад т.к. стоит на начальной станции'
    end
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if is_route_set?
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] if is_route_set?
  end

  def is_route_set?
    @route != nil
  end

end
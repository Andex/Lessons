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
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  attr_accessor :current_speed
  attr_reader :number, :current_station

  def initialize(number)
    @number = number
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
      p "Отправляем поезд со станции #{@current_station.name}"
      @current_station.send_train(self) if @current_station.trains.include?(self)
      @current_station = @route.stations[@route.stations.index(@current_station) + 1]
      @current_station.take_train(self)
      p "на станцию#{@current_station.name}"
    else
      p 'Поезд не может двигаться вперед т.к. стоит на конечной станции'
    end
  end
  
  def move_back
    return "У поезда не установлен маршрут" unless is_route_set?
    if @current_station != @route.stations.first
      p "Отправляем поезд со станции #{@current_station.name}"
      @current_station.send_train(self) if @current_station.trains.include?(self)
      @current_station = @route.stations[@route.stations.index(@current_station) - 1]
      @current_station.take_train(self)
      p "на станцию #{@current_station.name}"
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

  private
  
  # это вспомогательный  метод для разрешения перемещения поезда по маршруту, поэтому его можно убрать из интерфейса
  # не в protected потому что незачем переопределять данный метод т.к. маршрут поезду либо назначен, либо нет
  def is_route_set?
    @route != nil
  end

end
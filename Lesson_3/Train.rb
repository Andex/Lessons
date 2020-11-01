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
  attr_reader :number, :type, :quantity_railway_car

  def initialize(number, type, quantity_railway_car)
    @number = number
    @type = type
    @quantity_railway_car = quantity_railway_car
    @current_speed = 0
  end

  def speed_up(speed)
    self.current_speed = speed
  end

  def brake
    self.current_speed = 0
  end

  def change_quantity_railway_cars(change)
    if (change == 1) || (change == -1) && (current_speed == 0)
      @quantity_railway_car += change
    else
      p "Error. Можно прицеплять/отцеплять только по одному вагону за операцию и, когда поезд не движется!"
    end
  end

  def assign_route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.take_train(self)
  end

  def find_next_station(direction)
    @route.stations[@route.stations.index(@current_station) + direction]
  end

  # forward = 1, back = -1
  def move(direction)
    @current_station.send_train(self) if @current_station.train_list.include?(self.number)
    @current_station = find_next_station(direction)
    @current_station.take_train(self)
  end

  def nearest_stations
    p "Предыдущая станция #{find_next_station(-1).name}\nТекущая станция #{@current_station.name}\nСледующая станция #{find_next_station(1).name}"
  end

end
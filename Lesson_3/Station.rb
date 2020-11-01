# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station
  attr_reader :name
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = {}
  end

  def take_train(train)
    self.trains[train.number] = {type: train.type, quantity_railway_car: train.quantity_railway_car}
  end

  def send_train(train)
    self.trains.delete(train.number) if @trains.include?(train.number)
  end

  def show_trains_on_station
    passenger = trains.select{|train, info| info[:type] == "passenger"}
    cargo = trains.select{|train, info| info[:type] == "cargo"}
    print "Станция #{name}\nКоличество пассажирских поездов - #{passenger.count}\nКоличество грузовых поездов - #{cargo.count}"
  end

end

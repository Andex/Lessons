# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_reader :stations

  def initialize(starting_station, end_station)
    @stations = [starting_station, end_station]
  end

  def add_intermediate_station(station)
    stations << station
    stations[-1], stations[-2] = stations[-2], stations[-1]
  end
  
  def delete_intermediate_station(station)
    stations.delete(station)
  end

  def show_all_stations
    stations.each{|station| p station.name}
  end
end

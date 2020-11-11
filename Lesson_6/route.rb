class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(starting_station, end_station)
    @stations = [starting_station, end_station]
    register_instance
  end

  def add_intermediate_station(station)
    stations.insert(-2, station)
  end
  
  def delete_intermediate_station(station)
    stations.delete(station)
  end
end

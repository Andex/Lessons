class Route
  include InstanceCounter
  include Validation

  attr_reader :stations

  validate :stations, :presence

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

  # protected

  # def validate!
  #   raise TypeError, 'Invalid station name type' unless stations.first.name.is_a?(String) && stations.last.name.is_a?(String)
  # end
end

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(starting_station, end_station)
    @stations = [starting_station, end_station]
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_intermediate_station(station)
    stations.insert(-2, station)
  end

  def delete_intermediate_station(station)
    stations.delete(station)
  end

  protected

  def validate!
    raise TypeError, 'Invalid station name type' unless stations.first.name.is_a?(String) && stations.last.name.is_a?(String)
  end
end

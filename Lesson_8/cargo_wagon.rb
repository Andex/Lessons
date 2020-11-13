class CargoWagon < Wagon
  attr_reader :general_volume
  attr_accessor :number_of_occupied_volume

  def initialize(general_volume)
    @general_volume = general_volume
    @number_of_occupied_volume = 0
    super(:cargo)
  end

  def take_volume(volume)
    return nil if number_of_occupied_volume >= general_volume || volume > remaining_volume
    self.number_of_occupied_volume += volume
  end

  def remaining_volume
    general_volume - number_of_occupied_volume
  end

  protected

  def validate!
    super()
    raise "Invalid value general volume" unless general_volume > 0 && (general_volume.is_a?(Integer) || general_volume.is_a?(Float))
  end
end
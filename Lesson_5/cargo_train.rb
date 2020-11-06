class CargoTrain < Train

  def add_wagon(wagon)
    return nil if current_speed != 0
    return nil if wagon.is_coupled.nil?
    if wagon.class == CargoWagon
      wagons << wagon
      wagon.is_coupled = true
    end
  end
end
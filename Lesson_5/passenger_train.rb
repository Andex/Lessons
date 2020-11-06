class PassengerTrain < Train

  def add_wagon(wagon)
    return nil if current_speed != 0
    return nil if wagon.is_coupled
    if wagon.class == PassengerWagon
      wagons << wagon
      wagon.is_coupled = true
    end
  end
end
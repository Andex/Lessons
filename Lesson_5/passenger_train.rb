class PassengerTrain < Train
  attr_accessor :wagons

  def initialize(number)
    super(number)
    @wagons = []
  end

  def add_wagon(wagon)
    return "Error. К поезду нельзя прицепить вагон во время движения!" if current_speed != 0
    return "Error. Этот вагон уже прицеплен к другому поезду" if wagon.is_coupled
    if wagon.class == PassengerWagon
      wagons << wagon
      wagon.is_coupled = true
    else
      p "Error. К этому поезду можно прицепить только пассажирский вагон!"
    end
  end

  def remove_wagons(wagon)
    if current_speed == 0 || wagons.include?(wagon)
      wagons.delete(wagon)
      wagon.is_coupled = false
    else
      p "Error. Можно отцеплять вагон только когда поезд не движется и когда данный вагон есть у поезда!"
    end
  end
end
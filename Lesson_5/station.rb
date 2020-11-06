class Station
  attr_reader :name
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    self.trains << train
  end

  def send_train(train)
    self.trains.delete(train) if @trains.include?(train)
  end

  def trains_by_type(type)
    trains.each{|train| p train if train.class.to_s == type}
  end

end

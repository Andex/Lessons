class PassengerWagon < Wagon
  attr_reader :number_of_seats
  attr_accessor :number_of_occupied_seats

  validate :number_of_seats, :presence
  validate :number_of_seats, :type, Integer

  def initialize(number_of_seats)
    @number_of_seats = number_of_seats
    @number_of_occupied_seats = 0
    super(:passenger)
  end

  def take_the_seats
    raise 'All seats are already taken' if number_of_occupied_seats >= number_of_seats

    self.number_of_occupied_seats += 1
  end

  def number_of_free_seats
    number_of_seats - number_of_occupied_seats
  end

  # protected

  # def validate!
  #   super()
  #   raise 'Invalid value number of seats' unless number_of_seats.positive? && number_of_seats.is_a?(Integer)
  # end
end

require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'

@stations = []
@trains = []
@routes = []

def select_train
  p 'Выберете поезд'
  show_all_trains
  gets.chomp.to_i - 1
end

def select_route
  p 'Выберете маршрут'
  show_all_routes
  gets.chomp.to_i - 1
end

def show_all_stations
  @stations.each_with_index do |station, index|
    p "#{index + 1}: #{station.name}"
  end
end

def show_all_routes
  @routes.each_with_index do |route, index|
    p "#{index + 1}: #{route.stations.first.name} -> #{route.stations.last.name}"
  end
end

def show_all_trains
  @trains.each_with_index do |train, index|
    p "#{index + 1}: #{train.class.to_s} №#{train.number}"
  end
end

def create_station
  p 'Введите название станции'
  station_name = gets.chomp
  @stations << Station.new(station_name)
end

def create_train
  p 'Создать пассажирскийй поезд? +/-'
  passenger = gets.chomp
  p 'Введите номер поезда'
  train_number = gets.chomp
  if passenger == 'да'
    @trains << PassengerTrain.new(train_number)
  else
    @trains << CargoTrain.new(train_number)
  end
end

def create_route
  route = []
  show_all_stations
  p 'Введите номер начальной станции'
  start_station = @stations[gets.chomp.to_i - 1]
  route << start_station
  p 'Введите номер конечной станции'
  end_station = @stations[gets.chomp.to_i - 1]
  route = Route.new(start_station, end_station)
  p 'Составленный маршрут:'
  route.stations.each{|station| p station.name}
  @routes << route
  p @routes
end

def route_control
  number_route = select_route
  p "'+' добавить станцию в маршрут, '-' удалить"
  action = gets.chomp
  p "Выберете станцию и введите ее номер"
  show_all_stations
  index = gets.chomp.to_i - 1
  if action == "+"
    @routes[number_route].add_intermediate_station(@stations[index])
  else
    @routes[number_route].stations.delete(@stations[index])
  end
  p 'Маршрут изменен:'
  @routes[number_route].stations.each{|station| p station.name}
end

def assign_route
  train = select_train
  number_route = select_route
  @trains[train].assign_route(@routes[route_number])
  p "Поезду №#{@trains[train].number} назначен маршрут #{@routes[route_number].stations.first.name} -> #{@routes[route_number].stations.last.name}"
end

def add_wagons
  train = select_train
  if @trains[train].class == PassengerTrain
    @trains[train].add_wagon(PassengerWagon.new)
  else
    @trains[train].add_wagon(CargoWagon.new)
  end
  # p @trains[train]
end

def delete_wagons
  train = select_train
  if @trains[train].wagons != []
    @trains[train].remove_wagons(@trains[train].wagons.last)
    p 'Вагон отцеплен'
  else
    p 'Error. У поезда нет вагонов!'
  end
  # p @trains[train]
end

def move_train
  p 'aa', train = select_train
  p 'Отправить поезд вперед (введите +) по маршруту или назад (введите -)?'
  action = gets.chomp
  if action == "+"
    @trains[train].move_forward
  else
    @trains[train].move_back
  end
end

def show_stations_on_route
  number_route = select_route
  p 'eee', number_route
  @routes[number_route].stations.each{|station| p station.name}
end

def show_trains_on_station
  p 'Выберете станцию'
  show_all_stations
  station = gets.chomp.to_i - 1
  @stations[station].trains.each do |train|
    p "Поезд №#{train.number} #{train.class.to_s}"
  end
end

loop do
  p 'Введите:'
  p '1 - если хотите создать станцию'
  p '2 - если хотите создать поезд'
  p '3 - если хотите создать маршрут'
  p '4 - если хотите добавить или удалить станции в маршруте'
  p '5 - если хотите назначить маршрут поезду'
  p '6 - если хотите добавить вагоны к поезду'
  p '7 - если хотите отцепить вагоны от поезда'
  p '8 - если хотите перемещать поезд по маршруту'
  p '9 - если хотите посмотреть список станций в маршруте'
  p '10 - если хотите посмотреть список поездов на станции'
  p '0 - если хотите закончить программу'
  input = gets.chomp.to_i
  break if input == 0

  case input
  when 1
    create_station
    p 'Станция создана'
  when 2
    create_train
    p 'Поезд создан'
  when 3
    create_route
    p 'Маршрут создан'
  when 4
    route_control
  when 5
    assign_route
  when 6
    add_wagons
    p 'Соответсвующий вагон прицеплен'
  when 7
    delete_wagons
  when 8
    move_train
  when 9
    show_stations_on_route
  when 10
    show_trains_on_station
  end
  p 'Нажмите Enter для возврата к меню'
  gets.chomp
end
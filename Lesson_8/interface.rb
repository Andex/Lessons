class Interface
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @menu = ['чтобы закончить программу', 'чтобы создать станцию', 'чтобы создать поезд',
             'чтобы создать маршрут', 'чтобы добавить или удалить станции в маршруте',
             'чтобы назначить маршрут поезду', 'чтобы добавить вагоны к поезду',
             'чтобы отцепить вагоны от поезда', 'чтобы занять место или объем в вагоне',
             'чтобы перемещать поезд по маршруту', 'чтобы посмотреть список станций в маршруте',
             'чтобы посмотреть список поездов на станции', 'чтобы посмотреть список вагонов у поезда']
  end

  def start
    loop do
      p 'Введите:'
      @menu.each_with_index { |m, i| p "#{i} - #{m}" }
      input = gets.chomp.to_i
      break if input.zero?

      case input
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        route_control
      when 5
        assign_route
      when 6
        add_wagons
      when 7
        delete_wagons
      when 8
        take_smth_in_wagon
      when 9
        move_train
      when 10
        show_stations_on_route
      when 11
        show_trains_on_station
      when 12
        show_train_wagons(select_train)
      end
      p 'Нажмите Enter для возврата к меню'
      gets.chomp
    end
  end

  private

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

  def show_all_stations(stations = @stations)
    stations.each_with_index do |station, index|
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
      p "#{index + 1}: #{train.type} №#{train.number} кол-во вагонов #{train.wagons.size}"
    end
  end

  def create_station
    p 'Введите название станции'
    station_name = gets.chomp
    @stations << Station.new(station_name)
    p 'Станция создана'
  end

  def create_wagon(type)
    if type == :passenger
      p 'Укажите количество пассажирских мест в вагоне'
      PassengerWagon.new(gets.chomp.to_i)
    else
      p 'Укажите общий объем грузового вагона'
      CargoWagon.new(gets.chomp.to_f)
    end
  end

  def create_train
    p 'Создать пассажирскийй поезд? +/-'
    passenger = gets.chomp
    raise 'You should have entered + or -' unless ['+', '-'].include?(passenger)

    p 'Введите номер поезда'
    train_number = gets.chomp
    @trains << if passenger == '+'
                 PassengerTrain.new(train_number)
               else
                 CargoTrain.new(train_number)
               end
    p 'Поезд создан'
  rescue StandardError => e
    p e.message
    retry
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
    route.stations.each { |station| p station.name }
    @routes << route
    p 'Маршрут создан'
  end

  def route_control
    number_route = select_route
    p "'+' добавить станцию в маршрут, '-' удалить"
    action = gets.chomp
    p 'Выберете станцию и введите ее номер'
    if action == '+'
      show_all_stations
      index = gets.chomp.to_i - 1
      @routes[number_route].add_intermediate_station(@stations[index])
    else
      show_stations_on_route
      index = gets.chomp.to_i - 1
      @routes[number_route].stations.delete(@stations[index])
    end
  end

  def assign_route
    train = select_train
    route_number = select_route
    @trains[train].assign_route(@routes[route_number])
    p "Поезду №#{@trains[train].number} назначен маршрут #{@routes[route_number].stations.first.name} -> #{@routes[route_number].stations.last.name}"
  end

  def add_wagons
    train = select_train
    res = if @trains[train].type == :passenger
            @trains[train].add_wagon(create_wagon(:passenger))
          else
            @trains[train].add_wagon(create_wagon(:cargo))
          end
    if res.nil?
      p 'Error. Вы пытаетесь прицепить вагон к движущемуся поезду, не соответвующего типа или уже прицепленного к другому поезду!'
    else
      p 'Соответсвующий вагон прицеплен'
    end
  end

  def delete_wagons
    train = select_train
    if @trains[train].wagons != []
      res = @trains[train].remove_wagons(@trains[train].wagons.last)
      return p 'Error. Можно отцеплять вагон только когда поезд не движется и когда данный вагон есть у поезда!' if res.nil?

      p 'Вагон отцеплен'
    else
      p 'Error. У поезда нет вагонов!'
    end
  end

  def take_smth_in_wagon
    train = select_train
    p 'Выберете вагон'
    show_train_wagons(train)
    number_wagon = gets.chomp.to_i - 1
    if @trains[train].type == :passenger
      @trains[train].wagons[number_wagon].take_the_seats
      p 'Место успешно занято'
    else
      p 'Сколько объема хотите занять?'
      volume = gets.chomp.to_f
      @trains[train].wagons[number_wagon].take_volume(volume)
      p 'Указанный объем успешно занят'
    end
  end

  def move_train
    train = select_train
    p 'Отправить поезд вперед (введите +) по маршруту или назад (введите -)?'
    action = gets.chomp
    p "Отправляем поезд со станции #{@trains[train].current_station.name}" unless @trains[train].current_station.nil?
    if action == '+'
      res = @trains[train].move_forward
      return p 'Поезд не может двигаться вперед т.к. стоит на конечной станции' if res.nil?
    else
      res = @trains[train].move_back
      return p 'Поезд не может двигаться назад т.к. стоит на начальной станции' if res.nil?
    end
    p "на станцию #{@trains[train].current_station.name}"
  rescue StandardError
    p res
  end

  def show_stations_on_route
    number_route = select_route
    show_all_stations(@routes[number_route].stations)
  end

  def show_trains_on_station
    p 'Выберете станцию'
    show_all_stations
    station = gets.chomp.to_i - 1
    @stations[station].enum_trains do |train|
      p "Поезд №#{train.number} #{train.type}, количество вагонов - #{train.wagons.size}"
    end
  end

  def show_train_wagons(train)
    index = 1
    @trains[train].enum_wagons do |wagon|
      if @trains[train].type == :passenger
        p "#{index}: Вагон пассажирский с кол-вом мест #{wagon.number_of_seats}, свободно #{wagon.number_of_free_seats}"
      else
        p "#{index}: Вагон грузовой общим объемом #{wagon.general_volume}, свободно #{wagon.remaining_volume}"
      end
      index += 1
    end
  end
end

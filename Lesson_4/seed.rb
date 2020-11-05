require_relative 'train.rb'
require_relative 'station.rb'
require_relative 'route.rb'

s = Station.new("Vichuga")
ss = Station.new("Moscow")
s_s = Station.new("Ivanovo")

tr = Train.new("123a", "cargo", 43)
p "Train tr", tr
tr2 = Train.new("be23", "passenger", 12)
p "Train tr2", tr2, ''

r = Route.new(s, ss)
r.add_intermediate_station(s_s)
p "Route", r, s, ''

p "speed up 20"
tr.speed_up(20)
p tr
p "brake"
tr.brake
p tr, tr.quantity_railway_car
tr.add_railway_cars
p tr.quantity_railway_car
tr.remove_railway_cars
p tr.quantity_railway_car

tr.assign_route(r)
p "current station tr - ", s, "forward ->", s_s, ''
tr.move_forward
p "current station tr - ", s_s, "forward ->", ss, ''
tr.move_forward
p "current station tr - ", ss, "<- back", s_s, ''
tr.move_back
p "current station tr - ", ss
# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.

mounths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

p 'Введите три числа, которые обозначают число, месяц, год'
days, mounth, year = gets.chomp.split().map{|num| num.to_i}

num, number = 1, days
while num != mounth
  number += mounths[num - 1]
  num += 1
end

if mounth > 2 && ( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )
  number += 1
end

p number

# number = (mounth / 2) * 31 + ((mounth - 1) / 2) * 30 + days
# if mounth == 9 || mounth == 11
#   number += 1
# end

# if mounth > 2
#   if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
#     number -= 1
#   else
#     number -= 2
#   end
# end
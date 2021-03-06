# Прямоугольный треугольник. Программа запрашивает у пользователя 3 стороны треугольника и определяет, является ли треугольник прямоугольным
# (используя теорему Пифагора www-formula.ru), равнобедренным (т.е. у него равны любые 2 стороны) или равносторонним (все 3 стороны равны)
# и выводит результат на экран. Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти самую длинную сторону (гипотенуза)
# и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон.
# Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.

p 'Введите стороны треугольника через пробел'
a, b, c = gets.split().map{|str| str.to_f}.sort

if a == b && b == c
  p 'Треугольник равнобедренный и равносторонний, но не прямоугольный'
elsif a == b || a == c || b == c
  p 'Треугольник равнобедренный'
elsif c**2 == a**2 + b**2
  p 'Треугольник прямоугольный'
else
  p 'Треугольник не является равносторонним, равнобедренным или прямоугольным'
end

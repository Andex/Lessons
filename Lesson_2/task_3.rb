# Заполнить массив числами фибоначчи до 100

arr = []

fib0, fib1 = 1, 1
arr << fib0

until fib1 > 100
  arr << fib1
  fib0, fib1 = fib1, fib0 + fib1
end
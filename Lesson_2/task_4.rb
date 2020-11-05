# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = ('a'..'z').to_a

vowels = {
  a: (alphabet.index('a') + 1),
  e: (alphabet.index('e') + 1),
  i: (alphabet.index('i') + 1),
  o: (alphabet.index('o') + 1),
  u: (alphabet.index('u') + 1),
  y: (alphabet.index('y') + 1),
}
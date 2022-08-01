module AddStuff where

addStuff :: Integer -> Integer -> Integer
addStuff a b = a + b + 5

addTen :: Integer -> Integer
addTen = addStuff 5
fifteen :: Integer
fifteen = addTen 5

subtractStuff :: Integer -> Integer -> Integer
subtractStuff x y = x - y - 10
subtractOne :: Integer -> Integer
subtractOne = subtractStuff 1
result :: Integer
result = subtractOne 11
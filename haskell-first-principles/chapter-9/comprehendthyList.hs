module ListComp where

foo :: [(Int,Int)]
foo = [(x,y) | x <- mySqr, x < 50,
               y <- mySqr , y > 50]

mySqr :: (Num a, Enum a) => [a]
mySqr = [x^2 | x <- [1..5]]

myCube :: (Num a, Enum a) => [a]
myCube = [y^3 | y <- [1..5]]

-- MySqr is a list comprehension that creates a list from a generated list by squaring each of the elements in the list by 2
-- foo then takes this as a generator by making x and y each a generated list of the same function mySqr the output is going to be elements of the list 
-- x which is mySqr that are less than 50 and y which is mySqr that are greater than 50 and is going to exhaust all possible options should it meet that condition
-- while all elemtns of the list x return true all elements of the list y return false thus giving us a empty list
-- It cant contrust a list if theres only one part of the tuple thats True silly!

fooBar :: String
fooBar = [x | x <- "This is A List", elem x ['A'..'Z']]
-- were generating a list from a list, which is a string in this case. and were matching on uppercase letters should they meet the condtion true in the list x then make
-- a new list with the capital letter that meet true in the preicate.

acro :: String -> String
acro y = [x | x <- y, elem x ['A'..'Z']]

myString :: String -> String
myString xs = [x | x <- xs, elem x "aeiou"]

myTuple = [(x,y) | x <- mySqr, 
                   y <- myCube,
                   x < 50,
                   y < 50]

myTuple' = length myTuple
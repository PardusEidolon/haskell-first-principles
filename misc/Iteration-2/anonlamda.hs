module AnonLambda where

oddo n = case odd n of
    True -> f n
    False -> n
    where f = \n -> n + 1

addFive = \x -> \y -> (if x > y then y else x ) + 5

myFlip f = \x -> \y -> f y x

-- myFlip' ::  Show a => a -> a -> a -> a
myFlip' f x = f x


addOne :: Integer -> Integer
addOne x = x + 1

myval :: Integer
myval = (addOne 1) + (addOne 1)

bindExp :: Integer -> String
bindExp x =
    let z = y + x; y = 10 in
        "the integer was: " ++ show x ++ " and y was: " ++ show y ++ " and z was: " ++ show z
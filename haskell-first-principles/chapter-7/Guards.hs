{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Guards where
import System.Directory.Internal.Prelude (Fractional)

myAbs :: Integer -> Integer -> Integer
myAbs x y
    | x < y     = (-y)
    | x > y     = x + y
    | otherwise = x

blodNa :: Integer -> IO()
blodNa x
    | x < 135 = putStrLn "Well done you now have diabetis."
    | x > 145 = putStrLn "congrats you have no diabetis"
    | otherwise = putStrLn "diabetis"

-- Mr.Pyhthagorus said that c is the hypotenuse of the triangle.

isRight :: (Num a, Eq a) => a -> a -> a -> String
isRight a b c
    | a^2 + b^2 == c^2 = "pythagorus would be proud to call you his son."
    | otherwise = "a cat on crack can do better triganometry than you."

doggoYrs :: (Num a, Ord a) => a -> a
doggoYrs x
    | x <= 0 = 0
    | x <= 1 = x * 15
    | x <= 2 = x * 12
    | x <= 4 = x * 6
    | otherwise = x * 6

avgGrade :: Float -> Char
avgGrade x
    | y >= 0.9 = 'A'
    | y >= 0.8 = 'B'
    | y >= 0.7 = 'C'
    | y >= 0.59 = 'D'
    | y <  0.59 = 'F'
    where y = x / 100

-- now it's time for some guard duty
pal :: String -> Bool
pal xs 
    | xs == reverse xs  = True
    | otherwise = False

numbers x
    | x <  0  = (-1)
    | x == 0  = 0
    | x >  0  = 1
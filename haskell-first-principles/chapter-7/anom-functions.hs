module Anomfunc where

type Integers = Integer -> Integer -> Integer -> Integer

tripplethee :: Integer -> Integer
tripplethee x = x * 10

-- now for the anonymous part of the same function, heheheh

anomTrip :: Integer
anomTrip = (\x -> x * 3) 5

main :: IO()
main = do
    print ((show anomTrip) ++ " Balls")

-- ha, thats a good one jack. 'balls'...heh

mTh :: Integers
mTh = \x -> \y -> \z -> x * y * z

mThAnom x = \y -> \z -> x * y * z

-- rewrite expressions with lamda syntax now for example:
addOne x = x + 1
-- can be wiritten as:
addOne' = \x-> x + 1
-- Start here:
addOneIfOdd n = case odd n of
    True -> f n
    False -> n
    where f = \n -> n + 1

addFive :: (Num a, Ord a) => a -> a -> a
addFive = \x -> \y -> (if x > y then y ^ 5 else x)
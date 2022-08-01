module CasePractice where

funC :: (Eq a, Ord a) => a -> a -> a
funC x y = case x > y of 
    True -> x
    False -> y

funcTimes2 :: (Integral a, Num a) => a -> a
funcTimes2 n = case even n of
    True -> (+2) n
    False -> n

funcE :: (Num a, Ord a) => a -> a
funcE x = case compare x 0 of
    LT -> -1
    EQ -> 0
    GT -> 1
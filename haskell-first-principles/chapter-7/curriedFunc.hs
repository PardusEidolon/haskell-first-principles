module CurriedFunc where

curry' :: ((a, b) -> c) -> a -> b -> c
curry' f a b = f (a, b)

add :: (Int, Int) -> Int
add (x,y) = x + y

add' :: Int -> Int
add' = curry' add 2
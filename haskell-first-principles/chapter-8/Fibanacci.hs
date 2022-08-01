module Fibanacci where

fooNum :: Integral a => a -> a
fooNum 0 = 0
fooNum 1 = 1
fooNum x = fooNum (x - 1) + fooNum (x - 2)

-- The faster version...
fib:: Int -> Int
fib n = fib' 0 1 n

fib':: Int -> Int -> Int -> Int
fib' a b 0 = a
fib' a b n = fib' (a+b) a (n-1)

-- fooNum 3 = fooNum 2 + fooNum 1 = 3 

-- fooNum(5) = fooNum(4) + fooNum(3)
-- fooNum(4) = fooNum(3) + fooNum(2)
-- fooNum(3) = fooNum(2) + fooNum(1)
-- fooNum(2) = fooNum(1) + fooNum(0)
-- fooNum(1) = 1
-- fooNum(0) = 0

-- [0,1,1,2,3,5,8,13,21]

fooList :: [Int] -> [Int]
fooList x = map fib x
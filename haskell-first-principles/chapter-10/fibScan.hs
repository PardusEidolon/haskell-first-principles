module FibScan where

fibs :: Num a => [a]
fibs = (1 : scanl (+) 1 fibs)

fibTake :: [Int]
fibTake = take 20 fibs

fibWhile :: [Int]
fibWhile = takeWhile (<100) fibs

fibsN :: Int -> Int
fibsN xs = fibs !! xs

factorial :: [Int]
factorial = takeWhile (<100) (scanl (*) 1 [1..])
module MyTake where

myTake :: Int -> [a] -> [a]
myTake n _ | n <= 0 = []
myTake _ [] = []
myTake n (x:xs) = x : myTake (n - 1) xs


myTake' :: Int -> [a] -> [a]
myTake' _ [] = []
myTake' n (x:xs) = case n <= 0 of
    True -> []
    False -> x : myTake' (n - 1) xs

ifTake :: Int -> [a] -> [a]
ifTake _ [] = []
ifTake n (x:xs) = if n <= 0 then [] else x : myTake (n - 1) xs

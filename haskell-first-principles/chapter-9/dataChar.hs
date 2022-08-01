module Datachar where

import Data.Char

-- 2
lowerCase :: String
lowerCase = filter isUpper "HbEfLrLxO,"

-- 3
capitalise :: String -> String
capitalise [] = []
capitalise (x:xs) = toUpper x : xs

-- 4
capitaliseRec :: String -> String
capitaliseRec [] = []
capitaliseRec (x:xs) = toUpper x : capitaliseRec xs

-- 5
capitaliseHead1 :: String -> Char
capitaliseHead1 xs = toUpper $ head xs

-- 6 ~ the point free version
capitaliseHead :: String -> Char
capitaliseHead = toUpper . head
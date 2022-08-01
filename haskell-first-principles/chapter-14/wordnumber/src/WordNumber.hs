module WordNumber where


import Data.List (intersperse)

digitToWord :: Int -> String
digitToWord n 
    | n == 0  = "zero"
    | n == 1  = "one"
    | n == 2  = "two"
    | n == 3  = "three"
    | n == 4  = "four"
    | n == 5  = "five"
    | n == 6  = "six"
    | n == 7  = "seven"
    | n == 8  = "eight"
    | n == 9  = "nine"
    | n == 10 = "ten"
    | otherwise = error "Number exceeds current patterns"

digits :: Int -> [Int]
digits n = go n []
    where go n dig
            | d > 0     = go d (r:dig)
            | otherwise =      (r:dig)
            where d = n `div` 10
                  r = n `mod` 10

wordNumber :: Int -> String
wordNumber = concat . intersperse "-" . map digitToWord . digits
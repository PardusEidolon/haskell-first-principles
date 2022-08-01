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

-- let's open this box of cracker jacks! and party.
    -- digits 9 = go 9 []
    -- d = div 9 10 (where n is 9) = 0
    -- when 0 is greater then 0 which will fail
    -- then (r:dig) where 'r' = 9 mod 10 = 9 and digs is []
    -- so return [9] 


wordNumber :: Int -> String
wordNumber = concat . intersperse "-" . map digitToWord . digits

-- ok, one last breakdown before were done here...
    --  wordNumber 590 = digits 590 = [5,9,0] -> then map result to digitToWord = ["five-nine-zero"] -> intersperse with "-" = ["five","-","nine","-","zero"] 
    -- (but inserting the string "-" between the elements of our list) we then concat the lists of lists to give us "five-nine-zero".
    -- we can have whatever integer we want in word form as long as we staywithing the boud of type Integer.
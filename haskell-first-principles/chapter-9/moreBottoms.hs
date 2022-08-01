module Morebottom where

import Data.Bool

-- will it be ⫠ or will it actuallt return something?
-- 1. bottom
-- 2.Value
-- 3.bottom: it will evauluate the first element in the list but fail on the second because the ghc will swat you lol

-- 4 describe thy function in plain english please:
itIsMystery :: [Char] -> [Bool]
itIsMystery xs = map (\x -> elem x "aeiou") xs

-- This function takes elements of a "string" (or a list of chars) and evaulates the list of chars that we put in with the function list of chars
-- to return a list of bools. the condition here if the list of chars that we put in are equal to the one that is defined in the function
-- it will return True otherwise False

-- 5. a) The function will return a list of sqaured vaules by the integer 2
--    b) The function will return a list of all minimum values from the given ranged lists
--    c) The function will return a list of sum vaules by add all the vaules of each of the ranged lists


-- Recreate this function that does the same thing but use foldBool instead
foo = map (\x -> if x == 3 then (-x) else (x)) [1..10]

bar = map (\x -> bool x (-x) (x==3)) [1..10]
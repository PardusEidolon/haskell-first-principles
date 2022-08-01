module Filtering where

-- 1. x: a function with filter generating a list with multiples of 3 please
-- y: yeah, sure ok..ummm

foo :: (Eq a, Integral a) => [a] -> [a]
foo y = filter (\x -> (rem x 3) == 0) y

-- y: here you go...
-- x: your function looks good, your clear to go
-- y: have a good day, officer

-- 2. x: you forgot something in your function
--  y: oh my, really?
--  x: yeah, where is the function comp using length to tell me how many elements are in the list?
--  y: oh crap, give me second its in the glovebox

bar :: Integral a => [a] -> Int
bar x = length . foo $ x

-- y: there it is
-- x: hmmm, your function checks out, move along

-- 3. ok last one...make a function that removes all the articles
removeArticles :: [Char] -> [[Char]]
removeArticles ls = [x | x <- words ls, x/="a", x/="an", x/="the"]
-- so words is taking a string and seperates a string into a list of strings by matching on the spaces for it to turn a strings into a list of strings.
-- the list we give x returns a list of strings then we take that list and based on the predicate goes on to meet the following conditions for example;
-- if our elements in our generated list which is words ls is not equal to the first string in the list then include it in the new list otherwise throw it away

-- an alternative way for writing the same function
myFilter :: String -> [String]
myFilter = filter (not . (`elem` ["the", "a", "an"])) . words

-- heres another one
deArticulate :: String -> [String]
deArticulate = filter (\x -> not . elem x $ ["the", "a", "an"]) . words
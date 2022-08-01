module StandardFunctions where

import Data.Char
import Data.List

-- Example
-- The function 'and' returns True if all elements in the list of bools is True

andBool :: [Bool] -> Bool
andBool [] = True
andBool (x:xs) = if x == False then False else andBool xs

-- switching it up, using the (&&) operator, same function though.

andBool' :: [Bool] -> Bool
andBool' [] = True
andBool' (x:xs) = (&&) x $ andBool' xs

-- A Jedi Knight fliying circles in his jedi fighter once said "This is where the fun begins." ~ Anakin Skywalker
-- Returns True if any bool in the list is True, the distinction here is 'any' not 'all'
myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = (||) x $ myOr xs

-- Returns True if a -> Bool applied to any of the values in the list returns True.
myAny :: (a -> Bool) -> [a] -> Bool
myAny f [] = False
myAny f (x:xs) = f x || myAny f xs

-- Write the recursive function for elem, pls
myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem e xs = myAny (==e) xs

-- implelement a recursive reverse
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

-- implement a recursive squish, which concat's a list of lists
mySquish :: [[a]] -> [a]
mySquish [] = []
mySquish (x:xs) = x ++ (mySquish xs)

-- implement a recursive squishMap
squishMap :: (a -> [b]) -> [a] -> [b]
squishMap _ [] = []
squishMap f (x:xs) = f x ++ squishMap f xs

-- now squishAgain with the squishMap function
squishAgain :: [[a]] -> [a]
squishAgain (x:xs) = squishMap id (x:xs)

-- myMaximumBy takes a comparison function and a list and returns
-- the greatest element of the list based on the last value that
-- the comparison returned GT for.

mymaxiBy :: (a -> a -> Ordering) -> [a] -> a
mymaxiBy comp (x:xs) = go comp xs x
    where go _ [] tail = tail
          go comp (x:xs) tail = go comp xs (if comp tail x == GT then tail else x)

myminBy :: (a -> a -> Ordering) -> [a] -> a
myminBy comp (x:xs) = go comp xs x
    where go _ [] tail = tail
          go comp (x:xs) tail = go comp xs (if comp tail x == LT then tail else x)

-- time to spread your wings and write your own versions mini and maxi functions using the the functions we made above

myMax :: (Ord a) => [a] -> a
myMax = mymaxiBy compare

myMin :: (Ord a) => [a] -> a
myMin = myminBy compare
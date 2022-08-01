module Listproblems where

import Data.List

-- data type for question 7
data NestedList a = Elem a | List [NestedList a] deriving Show
-- i've got 99 problems and a list ain't one

-- 1. Find the last element of a List
myLast :: [a] -> a
myLast [] = error "you clearly suck at this."
myLast [x] = x
myLast (_:xs) = myLast xs

-- pointfree = freedom
myLastPF :: [a] -> a
myLastPF = head . reverse

-- 2. Find the Last but one element of a list
myButLast :: [a] -> a
myButLast [] = error "yup, I know. It's hard"
myButLast [x] = error "welcome to the club"
myButLast (x:xs) = 
    if length xs == 1 then x
    else myButLast xs

myButLastPF :: [a] -> a
myButLastPF = myLast . init

lastbut1safe :: Foldable t => t a -> Maybe a
lastbut1safe = fst . foldl (\(a,b) x -> (b,Just x)) (Nothing,Nothing)

-- 3. Find the K'th element of a list. The first element in the list is number 1.
elementAt :: (Eq b,Num b) => [a] -> b -> a
elementAt [] _ = error "Index out of bounds"
elementAt (x:_) 0 = x
elementAt (_:xs) i = elementAt xs (i-1)

-- elementAt [1,2,3] 2
--              2:3  1
--              3:[] 0
-- Another one...
elementAt':: [a] -> Int -> a
elementAt' list n 
    | length list < n = error "Index out of bounds sucka 🤙"
    | otherwise = fst . last $ zip list [0..n]

-- the if then else version...
elementifAt :: [a] -> Int -> a
elementifAt list n = 
    if length list < n 
        then error "Index out of bounds again fool 😂"
    else 
        fst . last $ zip list [0..n]

-- 4.Find the number of elements of a list.
myLength :: [a] -> Int
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

-- myLength [1,2,3]
--          1 [2,3]
--         1 + 1 [3]
--     1 + 1 + 1 []

-- 5. Reverse a list
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

myReverse2 :: [a] -> [a]
myReverse2 = foldl (flip (:)) []

-- 6. is xamax palindrome? or is xamax palindrome?
isPalindrome :: Eq a => [a] -> Bool
isPalindrome a = 
    a == myReverse a

-- 7. Flatten thy list's
flatten :: NestedList a -> [a]
flatten (Elem a) = [a]
flatten (List x) = concatMap flatten x

-- one without the concatMap..
flatten' :: NestedList a -> [a]
flatten' (Elem a ) =[a]
flatten' (List []) =[]
flatten' (List (x:xs)) = flatten x ++ flatten (List xs)

-- 8. Eliminate duplicates of list elements
compressPF :: Eq a => [a] -> [a]
compressPF = map head . group

compress :: Eq a => [a] -> [a]
compress (x:ys@(y:_))
    | x == y    = compress ys
    | otherwise = x : compress ys
compress ys = ys

-- @ is used to bind a name to the value of the whole pattern match.
-- ys is equal to the tail of the original list, and the head of ys is y. 

-- 9 pack a consecutive lists of duplicates into sub-lists
pack :: Eq a => [a] -> [[a]]
pack [] = []
pack (x:xs) = let (first,rest) = span (==x) xs
               in (x:first) : pack rest

-- heres a takeWhile version
pack' :: (Eq a) => [a] -> [[a]]
pack' [] = []
pack' (x:xs) = (x : takeWhile (==x) xs) : pack (dropWhile (==x) xs)


-- 10. Run-length encoding of a list.
encode :: Eq a => [a] -> [(Int, a)]
encode xs = map (\x-> (length x,head x)) $ group xs

encode' :: Eq a => [a] -> [(Int, a)]
encode' (x:xs) = [(length (x:xs),x) | (x:xs) <- group xs]

encodePF :: Eq a => [a] -> [(Int, a)]
encodePF = map (\x -> (length x, head x)) . group

encode'' :: Eq a => [a] -> [(Int, a)]
encode'' [] = []
encode'' (x:xs) = (length $ x : takeWhile (==x) xs, x)
                 : encode (dropWhile (==x) xs)

-- passing a result into our pack function then encoding it with our encode function
packEncode :: Eq a => [a] -> [(Int,a)]
packEncode xs = enc . pack $ xs
    where enc = foldr (\x acc -> (length x, head x) : acc) []

-- When go through the foldr chapter on lists maybe I'll get this or my brain will go Just no
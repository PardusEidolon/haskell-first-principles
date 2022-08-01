module FuncFolds where


myOr :: [Bool] -> Bool
myOr = foldr (||) False

myAny :: (a -> Bool) -> [a] -> Bool
myAny f ls = myOr $ map f ls

-- -- direct recursion, not using (&&)
myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x:xs) = if x == False then False else myAnd xs

-- direct recursion, using (&&)
myAnd' :: [Bool] -> Bool
myAnd' [] = True
myAnd' (x:xs) = x && myAnd xs

-- fold, not point-free
-- in the folding function
myAnd'' :: [Bool] -> Bool
myAnd'' = foldr (\a b -> if a == False then False else b) True

-- fold, both myAnd and the folding6


-- 3.

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem e xs = myAny (==e) xs

-- fold version
myElem' :: (Eq a) => a -> [a] -> Bool
myElem' e ls = foldr (\a b -> b || a == e) False ls

-- 4.

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

rvsFold :: [a] -> [a]
rvsFold ls = foldl (\b a -> a : b) [] ls

-- 5. 

myMap :: (a -> b) -> [a] -> [b]
myMap f ls = foldr (\a b -> f a : b) [] ls

-- 6.

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f ls = foldr (\a b -> if f a then a : b else b) [] ls

-- 7.

squish :: [[a]] -> [a]
squish ls = foldr (++) [] ls

-- 8.
squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f ls= foldr ((++) . f ) [] ls

-- 9.
squishAgain :: [[a]] -> [a]
squishAgain = squishMap id

-- 10.
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy f = head . foldr (\a b -> case b of 
                        [] -> [a]
                        (b:bs) -> if f a b == GT then [a] else [b]
                      ) []

myMaximumBy' :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy' f ls = foldl (\b a -> if f b a == GT then b else a) (head ls) ls


-- 11.
myMinBy :: (a -> a -> Ordering) -> [a] -> a
myMinBy f ls = foldl (\b a -> if f b a == LT then b else a) (head ls) ls
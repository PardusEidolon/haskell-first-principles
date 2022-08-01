module MyLookUp where

import Data.Maybe
-- a function that takes a list of tuples with a number for the first value and a string on the right
-- we match on the left argument of the tuple by lifting the structure
-- we need a function that patern matches the tuple and it's number and returning us the right value
-- we also need to fmap this function over our structure depending on the number that is used to traverse the list

type Key = Int

-- example values
foo :: [(Int,String)]
foo = [(1,"Jack"),(2,"John"),(3,"Harry")]

baz :: [(Int,String)]
baz = [(4,"Jane"),(5,"Brie"),(6,"Angel-bea")]
-- 

-- Original function on hackage
-- becuase its a tupple we can pattern match both the tuple and the list 
lookup' :: (Eq a) => a -> [(a,b)] -> Maybe b
lookup' key []          =  Nothing
lookup' key ((x,y):xys)
    | key == x           =  Just y
    | otherwise          =  lookup' key xys
-- 

-- funcy Version with fmapn

filterIt :: Key -> (Key, String) -> Maybe String
filterIt key (x,y) = case key == x of
    True -> Just y
    False -> Nothing

myLookup :: Key -> [(Key,String)] -> Maybe String
myLookup key = (itsNothing . fmap (filterIt key))

itsNothing :: [Maybe String] -> Maybe String
itsNothing [] = Nothing
itsNothing (x:xs) = case isJust x of
        True -> x
        False -> itsNothing xs
-- 

-- an all in one shabang
anotherLookup :: Key -> [(Key,String)] -> Maybe String
anotherLookup _ [] = Nothing
anotherLookup key (x:xs)
        | fst x == key = Just $ snd x
        | otherwise    = anotherLookup key xs

-- another one...
ifILookup :: Key -> [(Key,String)] -> Maybe String
ifILookup key list = go list
    where 
        go [] = Nothing
        go ((x,y):tail) = if key == x then Just y else go tail

-- ok another one...
fLookup :: Key -> [(Key,String)] -> Maybe String
fLookup key list = 
        let fs = fmap (filterIt key) list
        in 
            go fs
    where 
        go [] = Nothing
        go (x:xs) = if isJust x then x else go xs
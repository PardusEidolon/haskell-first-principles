module Tmp where

import  Data.Int
import Data.Time
import Data.Time.Calendar.OrdinalDate

main :: IO()
main = do
        putStrLn $ "Int8:" ++ show (maxBound :: Int8)
        putStrLn $ "Int16:" ++ show (maxBound :: Int16)
        putStrLn $ "Int32:" ++ show (maxBound :: Int32)
        putStrLn $ "Int64:" ++ show (maxBound :: Int64)

newtype Goat = Goat Int deriving (Eq,Show)

data Record = Record { word    :: String,
                       number  :: Int,
                       fractal :: Float } | Empty deriving (Show,Eq)


newtype Numba = Numba Int deriving Show
data Expr = Add Numba Numba | Minus Numba deriving Show

record :: Record
record = Record "Record" 1209 22.5


sqr :: String
sqr = show $ 2 ^ 2


bind :: IO()
bind = do
        let x = sqr
        putStrLn x
day1 = ModifiedJulianDay 59600

foo :: Goat -> Bool
foo (Goat n) = n > 42

maybz :: Integer -> Maybe Integer
maybz n = if even n then Just n else Nothing

mRecord :: Record -> Maybe Int
mRecord (Record _ _ _) = Just 42
mRecord _              = Nothing

notSpace :: Char -> Maybe Char
notSpace s
        | s /= ' '  = Just s
        | otherwise = Nothing

replaceSpaces :: String -> Char -> String
replaceSpaces s c = replace s
        where
             replace [] = []
             replace (x:xs) =
                     case notSpace x of
                             Just x -> x : replace xs
                             Nothing -> c : replace xs

isEven :: (Num a,Integral a) => a -> Maybe a
isEven i = if even i then Just (i^10) else Nothing

isEven' :: Integer -> Maybe Integer
isEven' i 
        | even i    = Just i
        | otherwise = Nothing

isEven'' :: Integer -> Maybe Integer
isEven'' i = 
        case even i of
                True -> Just i
                False -> Nothing

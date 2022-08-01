module LookUps where

import Data.Char ( toUpper )
import Data.List (elemIndex)

foo :: Int -> Maybe String
foo x = 
    lookup x [ (3,"hello")
             , (4,"sup")
             , (5,"hola")
             , (6,"bonjour")]
baz :: Int -> Maybe String
baz y = 
    lookup y [ (7,"kia ora")
             , (8,"waddup")
             , (9,"dude")
             , (10,"wonk")]

numba :: Int -> Maybe Int
numba z = 
    lookup z [ (2,33)
             , (3,40)
             , (4,50)
             , (5,66)]

numbas :: Int -> Maybe Int
numbas n = 
    lookup n [ (6,67)
             , (7,70)
             , (8,83)
             , (9,91)]

inCase :: Int -> String
inCase y = case baz y of
    Just s -> case s of
        s:xs -> toUpper s:xs
        [] -> []
    Nothing -> "better luck next time"

-- exercise time

added ::Maybe Integer 
added = fmap (+3) $ lookup 3 $ zip [1,2,3] [4,5,6]

y ::Maybe Integer 
y = lookup 3 $ zip [1,2,3] [4,5,6]

z::Maybe Integer 
z= lookup 2 $ zip [1,2,3] [4,5,6]

tupled :: Maybe (Integer,Integer)
tupled = fmap (,) y <*> z

-- Element Index

x' ::Maybe Int 
x' = elemIndex 3 [1,2,3,4,5] 

y' :: Maybe Int
y' = elemIndex 4 [1,2,3,4,5] 

max' ::Int->Int ->Int 
max' = max 

maxed ::Maybe Int 
maxed = fmap max' x' <*> y'

-- Summed

xs :: [Integer]
xs= [1,2,3] 
ys :: [Integer]
ys= [4,5,6] 

xe::Maybe Integer 
xe = lookup 3 $ zip xs ys 

ye::Maybe Integer 
ye= lookup 2 $ zip xs ys 

summed ::Maybe Integer 
summed = fmap sum $ fmap (,) xe <*> ye
{-# OPTIONS_GHC -Wno-deferred-type-errors #-}

module Typecheck where

import Data.List

data Person = Person deriving (Eq,Show)

printPerson :: Person -> IO ()
printPerson person = putStrLn (show person)


data Mood = Blah | Woot deriving (Eq, Ord, Show)

settleDown :: Mood -> Mood
settleDown x =
  if x == Woot
    then Blah
    else x

type Subject = String

type Verb = String

type Object = String

data Sentence
  = Sentence Subject Verb Object
  deriving (Eq, Show)

s2 = Sentence "Julie" "loves" "dogs"

-- some rocks, caue ya know rocks. I like rocks

data Rocks = 
  Rocks String deriving (Eq, Ord, Show)

data Yeah = 
  Yeah Bool deriving (Eq, Ord, Show)

data Papu =
  Papu Rocks Yeah
  deriving (Eq, Ord, Show)

allPapusAreEqual :: Papu -> Papu -> Bool
allPapusAreEqual x y = x == y

flaps :: Papu
flaps = Papu (Rocks "granite") (Yeah True)

crepes :: String -> Bool -> Papu
crepes a b = Papu (Rocks a ) (Yeah b)

comparedPaps :: Papu -> Papu -> Bool
comparedPaps  x y = x > y

-- I can match types better than I can match on tinder :( press f.

i :: Num a => a
i = 1

f :: RealFrac a => a
f = 1.0 + 1.0

freud :: Ord a => a -> a
freud x = x

freud' :: Int -> Int
freud' x = x

myX = 1 :: Int

sigmund :: Int -> Int
sigmund x = myX + x

jung :: [Int] -> Int
jung xs = head (sort xs)

mySort :: [Char] -> [Char]
mySort = sort

curriedsort :: [Char] -> Char
curriedsort xs = head (mySort xs)

-- Twae kwon chunk!

chk :: Eq b => (a -> b) -> a -> b -> Bool
chk f a b = f a == b


arith :: Num b => (a -> b) -> Integer -> a -> b
arith f a b = f b + fromIntegral a

-- arith (\x -> 3) 3 "name"
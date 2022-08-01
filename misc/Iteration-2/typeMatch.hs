module MatchType where

import Data.List

i :: a -> a
i a = a

f :: RealFrac a => a
f = 1.0

freud :: Ord a => a -> a
freud a = a

freud' :: Int -> Int
freud' x = x

myX = 1 :: Int

sigmund :: Int -> Int
sigmund x = myX

jung :: [Int] -> Int
jung x = head (sort x)

young :: [Char] -> Char
young x = head (sort x)

mySort :: Ord a => [a] -> [a]
mySort x = sort x

signifier :: Ord a => [a] -> a
signifier a = head (mySort a)

chk :: Eq b => (a -> b) -> a -> b -> Bool
chk f a b = f a == b

f' :: a -> Bool
f' _ = True

arith :: Num b => (a -> b) -> Integer -> a -> b
arith f x y = f y * fromIntegral x 

f'' :: Num b => a -> b
f'' _ = 20
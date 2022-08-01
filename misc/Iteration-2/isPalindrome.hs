module Palindrome where

isPalindrome :: Eq a => [a] -> Bool
isPalindrome x = reverse x == x

myAbs :: Integer -> Integer
myAbs x = if 10 + x == 10
            then 999999
        else 0

f :: (a, b) -> (c, d) -> ((b,d),(a,c))
f x y = ((snd x, snd y), (fst x, fst y))

type Name = String

xs :: Name -> Name -> Name
xs f y = f ++ y
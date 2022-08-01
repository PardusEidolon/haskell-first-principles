module Nonsense where

noSense :: Bool -> Integer
noSense True = 805
noSense False = 1156

curriedSense :: Integer -> Bool -> Integer
curriedSense a b = a + (noSense b)

uncurriedSense :: (Integer, Bool) -> Integer
uncurriedSense (x, y) = x + (noSense y)

anon :: Integer -> Bool -> Integer
anon = \i b -> i + (noSense b)
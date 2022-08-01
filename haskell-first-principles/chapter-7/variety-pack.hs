module VarietyPack where

-- give the following types to the following types.

tupVal :: (Integer, Char)
tupVal = (1,'b')

k :: (a,b) -> a
k (x,y) = x

k1 :: Num a => (a,b) -> a
k1 (x,y) = x

k2 :: (String,Integer) -> String
k2 (a,b) = a

k3 :: (Integer,Bool) -> Integer
k3 (a,b) = a

-- ok everybody watch this...

f :: (a,b,c) -> (d,e,f) -> ((a,d),(c,f))
f (x,_,z) (a,_,c) = ((x,a), (z,c))
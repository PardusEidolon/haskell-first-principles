module TupleFunctions where

addEmUp :: Num a => (a,a) -> a
addEmUp (x,y) = x + y

addEmUp2 :: Num a => (a,a) -> a
addEmUp2 tup = (fst tup) + (snd tup)


-- VARIETY PACK EXERCISES
-- The type of k is (a,b) -> a
-- k1 :: Integer this not the same type of k2 but the same type of k3
-- k2 :: String ^
-- k3 :: Integer ^^
-- k1 and k3 will return 3 as a result

f :: (a, b, c) -> (d, e, f) -> ((a, d), (c, f))
f (a,_,c) (d,_,f)= ((a, d), (c, f))


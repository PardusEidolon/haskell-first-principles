module Tuple where

tupFunc :: (Int, [a]) 
        -> (Int, [a]) 
        -> (Int, [a])
tupFunc (a, b) (c, d) = ((a + c), (b ++ d))

f :: (a,b) -> (c,d) -> ((b,d), (a,c))
f (a,b) (c,d) = ((b,d), (a,c))
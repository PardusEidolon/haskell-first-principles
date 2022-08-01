module Tupleconcat where

tupConcat :: (String, [a]) -> (String, [a]) -> (String, [a])
tupConcat (a, b) (c, d) = ((a ++ c), (b ++ d))

boolMe :: (Integer, Integer ) -> Bool
boolMe (a, b) = a == b

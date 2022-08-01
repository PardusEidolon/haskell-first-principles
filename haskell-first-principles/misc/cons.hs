module Definingthecons where

data List a = Null | Cons a (List a) deriving Show

-- our own version of what a cons is...
f :: Num a => List a
f = Cons 1 (Cons 2 (Cons 3 Null))
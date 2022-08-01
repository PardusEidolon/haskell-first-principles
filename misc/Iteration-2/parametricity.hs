module Parametrics where

id' :: a -> a
id' a = a

parametric :: a -> a -> a
parametric x y = x

parametric' :: a -> a -> a
parametric' x y = y

f' :: Integer -> Float -> Float 
f' a b = b
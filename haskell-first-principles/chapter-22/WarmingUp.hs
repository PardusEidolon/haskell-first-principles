module WarmingUp where

import Data.Char

cap :: [Char] -> [Char] 
cap xs = map toUpper xs 

rev :: [Char] -> [Char]
rev xs = reverse xs

compossed :: [Char] -> [Char]
compossed = cap . rev

fmapped :: [Char] -> [Char]
fmapped = fmap cap rev

tuppled :: [Char] -> ([Char],[Char])
tuppled = fmap (,) cap <*> rev

monadic :: [Char] -> ([Char],[Char])
monadic = do
    a <- cap
    b <- rev
    return ((,) b a)

monBind :: [Char] -> ([Char],[Char])
monBind = compossed >>= (,) 
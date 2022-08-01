module AsPattern where

import Data.Char

f :: Show a => (a,b) -> IO (a,b)
f t@(a,_) = do
        print a
        return t

doubleUp :: [a] -> [a]
doubleUp [] = []
doubleUp xs@(x:_) = x : xs

---

isSubseqOf :: (Eq a) => [a] -> [a] -> Bool
isSubseqOf [] _ = True
isSubseqOf (h1:_) [] = False  
isSubseqOf l1@(h1:t1) (h2:t2) = if h1 == h2 then isSubseqOf t1 t2 else isSubseqOf l1 t2

---
capitalizeWords :: String -> [(String,String,String)]
capitalizeWords = map func . words
    where func s@(h:t) = (s,toUpper h : t,map toUpper s)
module FoldFunc where

pab :: [String]
pab = ["apple","monkey","book"]


foldpab :: String
foldpab = foldl (\b a -> take 3 a) "" pab
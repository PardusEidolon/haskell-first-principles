module Trees where

data Tree = Leaf | Node Int Tree Tree deriving Show

maple :: Tree
maple = Leaf
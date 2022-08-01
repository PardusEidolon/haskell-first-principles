module Binarytree2 where

data BinaryTree a = 
      Leaf
    | Node (BinaryTree a) a (BinaryTree a) deriving (Eq,Show)

unfoldTree :: (a -> Maybe (a,b,a)) -> a -> BinaryTree b
unfoldTree f e = case f e of
    Just (lt,l,rt) -> Node (unfoldTree f lt) l (unfoldTree f rt)
    Nothing -> Leaf

buildTree :: Integer -> BinaryTree Integer
buildTree n = unfoldTree (treeHelper n) 0

treeHelper :: Integer -> Integer -> Maybe (Integer,Integer ,Integer)
treeHelper n i = if n > i 
                    then Just (i +1,i,i+1) 
                else Nothing
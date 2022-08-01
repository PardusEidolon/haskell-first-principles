module BinaryTree where

data BinaryTree a = Leaf 
                    | Node (BinaryTree a) a (BinaryTree a) 
                    deriving (Eq, Ord, Show)

-- left and right are just arbitrary names for clarity, it helps with understanding the structure when pattern matching
insert' :: Ord a => a -> BinaryTree a -> BinaryTree a
insert' b Leaf = Node Leaf b Leaf
insert' b (Node left a right)
    | b == a = Node left a right
    | b < a = Node (insert' b left) a right
    | b > a = Node left a (insert' b right)

mapTree :: (a -> b) -> BinaryTree a -> BinaryTree b
mapTree _ Leaf = Leaf
mapTree f (Node left a right) = Node (mapTree f left) (f a) (mapTree f right)

testTree :: BinaryTree Integer
testTree = Node (Node Leaf 3 Leaf) 1 (Node Leaf 4 Leaf)
testTree' :: BinaryTree Integer
testTree' = Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)

mapExpected :: BinaryTree Integer
mapExpected = Node (Node Leaf 4 Leaf) 2 (Node Leaf 5 Leaf)

mapOkay :: String
mapOkay = case mapTree (+1) testTree == mapExpected of
          True       ->       "Your good!"
          otherwise  -> error "Not okay!"

preorder :: BinaryTree a -> [a]
preorder Leaf = []
preorder (Node lt a rt) = [a] ++ preorder lt ++ preorder rt

inorder :: BinaryTree a -> [a]
inorder Leaf = []
inorder (Node lt a rt) = inorder lt ++ [a] ++ inorder rt

postorder :: BinaryTree a -> [a]
postorder Leaf = []
postorder (Node lt a rt) = postorder lt ++ postorder rt ++ [a]

foldTree :: (a -> b -> b) -> b -> BinaryTree a -> b
foldTree _ v Leaf = v
foldTree f v (Node lt a rt) = foldTree f (f a (foldTree f v lt)) rt

-- tests
testPreorder :: IO ()
testPreorder = if preorder testTree' == [2, 1, 3]
               then putStrLn "Preorder fine!"
               else putStrLn "Bad news bears."

testInorder :: IO ()
testInorder = if inorder testTree' == [1, 2, 3]
               then putStrLn "Inorder fine!"
               else putStrLn "Bad news bears."

testPostorder :: IO ()
testPostorder = if postorder testTree' == [1, 3, 2]
               then putStrLn "Postorder fine!"
               else putStrLn "Bad news bears."

main :: IO ()
main = do
        testPreorder
        testInorder
        testPostorder
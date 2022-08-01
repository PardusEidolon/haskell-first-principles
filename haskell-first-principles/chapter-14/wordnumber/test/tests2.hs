module Tests2 where

import Test.QuickCheck
import Test.Hspec
import Data.List (sort)

listOrdered :: (Ord a) => [a] ->Bool 
listOrdered xs = 
    snd $ foldr go (Nothing, True) xs 
        where go _ status@(_, False) = status 
              go y (Nothing, t) = (Just y, t) 
              go y (Just x, t) = (Just y, x >= y)

prop_listOrderedString :: String -> Bool
prop_listOrderedString xs = listOrdered $ sort xs

prop_listOrderedInt :: [Int] -> Bool
prop_listOrderedInt ls = listOrdered $ sort ls

-- Asscociation
plusAssociative :: (Num a,Eq a) => a -> a -> a -> Bool
plusAssociative x y z = x + (y + z) == (x + y) + z

plusCommutative :: (Num a,Eq a) => a -> a -> Bool
plusCommutative x y = x + y == y + x

-- multiplication
multAssociative :: (Num a,Eq a) => a -> a -> a -> Bool
multAssociative x y z = x * (y * z) == (x * y) * z

multCommutative :: (Num a,Eq a) => a -> a -> Bool
multCommutative x y = x * y == y * x

-- quot rem
quotRem' :: (Integral a,Eq a) => a -> a -> Bool
quotRem' x y = (quot x y)*y + (rem x y) == x

-- properties
prop_plusAssociative :: Int -> Int -> Int -> Bool
prop_plusAssociative a b c = plusAssociative a b c

prop_plusCommutative :: Int -> Int -> Bool
prop_plusCommutative x y = plusCommutative x y

prop_multAssociative :: Int -> Int -> Int -> Bool
prop_multAssociative x y z = multAssociative x y z

prop_multCommutative :: Int -> Int -> Bool
prop_multCommutative x y = multCommutative x y

prop_quotRem :: Int -> Int -> Bool
prop_quotRem x y = quotRem' x y

prop_reverse :: String -> Bool
prop_reverse x  = (reverse . reverse $ x) == x

prop_dollarsign :: Fun String Int -> String -> Bool
prop_dollarsign (Fn f) a = f a == (f $ a)

prop_point :: Fun Int String -> Fun String Int -> String -> Bool
prop_point (Fn f) (Fn g) a = (f . g $ a) == f (g a)

prop_foldrAppend :: String -> String -> Bool
prop_foldrAppend x y = foldr (:) x y == (flip (++)) x y

prop_foldrConcatString :: [String] -> Bool
prop_foldrConcatString a = foldr (++) [] a == concat a

prop_lengthList :: Int -> String -> Bool
prop_lengthList n xs = (length . take n $ xs) == n
-- test fails, negative numbers return a list of zero therefore dont match, function needs more logic to filter out cases that are invalid

prop_showRead :: Int -> Bool
prop_showRead x = (read . show $ x) == x

-- property failures

prop_squareIdentity :: NonZero Float -> Bool
prop_squareIdentity (NonZero x) = x == (square . sqrt $ x)
    where square x = x * x

-- does this fail because it is a subclass of num?
-- Haskell apprently does not have native high precision floating numbers?
-- IEEE 724 floating point numbers sate NaN is not equal to anything
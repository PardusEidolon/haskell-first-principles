module Exrcises where

import Data.Monoid 
import Control.Applicative
import Test.QuickCheck
-- import qualified Data.Validation as V
import Test.QuickCheck.Checkers 
import Test.QuickCheck.Classes

data List a = Nil | Cons a (List a) deriving (Show,Eq)

newtype ZipList' a = ZipList' (List a) deriving (Eq,Show)

data Validation e a = Failure' e | Success' a deriving (Eq,Show)
-- instance Monoid a => Semigroup (List a) where
--   (<>) Nil _  = Nil
--   (<>) _ Nil  = Nil
--   (<>) (Cons x xs) ys = Cons x $ xs <> ys

-- instance Monoid a => Monoid (List a) where
--   mempty = Cons mempty Nil
--   mappend = (<>)

instance Eq a => EqProp (ZipList' a) where
  xs =-= ys = xs' `eq` ys'
    where xs' = let (ZipList' l) = xs
                in take' 3000 l
          ys' = let (ZipList' l) = ys
                in take' 3000 l

instance Functor ZipList' where
  fmap f (ZipList' xs) = ZipList' $ fmap f xs

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a la) = Cons (f a) (fmap f la)

instance Functor (Validation e) where
  fmap _ (Failure' e) = Failure' e
  fmap f (Success' a) = Success' (f a)

instance Monoid m => Applicative (Validation m) where
  pure = Success'
  (<*>) _ (Failure' e') = Failure' e'
  (<*>) (Failure' e) _  = Failure' e
  (<*>) (Success' f) (Success' xs) = Success' (f xs) 
  (<*>) (Failure' e) (Failure' e') = Failure' (e <> e')

instance Applicative List where
  pure a = Cons a Nil
  (<*>) Nil _ = Nil
  (<*>) fs xs = flatMap (\f -> fmap f xs) fs

instance Applicative ZipList' where
  pure a = ZipList' (Cons a Nil)
  (<*>) (ZipList' xf) (ZipList' xs)  = ZipList' $ xf <*> xs

instance Arbitrary a => Arbitrary (List a) where
  arbitrary  = do 
    a <- arbitrary
    b <- arbitrary 
    frequency [(1, return Nil), (2, Cons <$> (return a) <*> (return b))]

instance Arbitrary a => Arbitrary (ZipList' a) where
  arbitrary  = do 
    a <- arbitrary
    frequency [(1, return $ ZipList' Nil), (2, return $ ZipList' a)]

instance Eq a => EqProp (List a) where 
    (=-=) = eq

append :: List a -> List a -> List a 
append Nil ys = ys 
append (Cons x xs) ys = Cons x $ xs `append` ys

fold :: (a -> b -> b) -> b ->List a -> b 
fold _ b Nil = b 
fold f b (Cons h t) = f h (fold f b t)

concat' :: List (List a) -> List a 
concat' = fold append Nil

flatMap :: (a ->List b) ->List a ->List b 
flatMap _ Nil = Nil
flatMap f as = concat' $ fmap f as

take' :: Int -> List a ->List a 
take' _ Nil = Nil
take' n (Cons x xs) = if n <= 0 then Nil else Cons x ( take' (n - 1) xs ) 

-- for science

toMyList :: [a] -> List a
toMyList = foldr Cons Nil

xs :: List Integer
xs = toMyList [1, 2, 3]

c :: a -> List a -> List a
c = Cons

f :: Integer -> List Integer
f x = x `c` (c 9  Nil)

foobar :: List (Sum Integer)
foobar = toMyList . map Sum $ [1..3]
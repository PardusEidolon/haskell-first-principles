{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE UndecidableInstances #-}
module Main where

import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes
import Data.Monoid
import Control.Applicative

data Expr a = Expr a deriving (Show,Eq,Ord)

instance Semigroup a => Semigroup (Expr a) where
  Expr a <> Expr b = Expr (a <> b)

instance Monoid a => Monoid (Expr a) where
  mempty = Expr mempty
  mappend = (<>)

instance Functor Expr where
  fmap f (Expr a) = Expr (f a)

instance Applicative Expr where
  pure = Expr
  (Expr f) <*> (Expr a) = Expr (f a)

instance Monad Expr where
  return = pure
  (Expr a) >>= f = f a

instance Foldable Expr where
  foldr f b (Expr a) = f a b
  foldl f b (Expr a) = f b a
  foldMap f (Expr a) = f a

instance Traversable Expr where
  traverse f (Expr a) = fmap Expr (f a)

instance Arbitrary a => Arbitrary (Expr a) where
  arbitrary = do
    a <- arbitrary
    return $ Expr a

instance Eq a =>  EqProp (Expr a) where
  (=-=) = eq
-- ===
-- 2.
newtype Identity a = Identity a deriving (Show,Ord,Eq)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)
instance Foldable Identity where
  foldMap f (Identity ta) = f ta
instance Applicative Identity where
  pure = Identity
  (<*>) (Identity f) (Identity a) = Identity (f a)
instance Traversable Identity where
  traverse f (Identity ta) = Identity <$> (f ta)
instance Eq a => EqProp (Identity a) where
  (=-=) = eq
instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = fmap Identity arbitrary
-- 
-- 3.
newtype Constant a b = Constant { getConstant :: a } deriving (Show,Eq,Ord)

instance Functor (Constant a) where
  fmap _ (Constant a) = Constant a

instance Monoid a => Applicative (Constant a) where
  pure a = Constant mempty
  (<*>) (Constant f) (Constant b) = (Constant (f <> b))

instance Monoid a =>  Foldable (Constant a) where
  foldMap _ (Constant _) = mempty

instance Monoid a => Traversable (Constant a) where
  traverse _ (Constant a) = Constant <$> pure a

instance (Eq a, Eq b) => EqProp (Constant a b) where
  (=-=) = eq

instance (Arbitrary a,Arbitrary b) => Arbitrary (Constant a b) where
  arbitrary = fmap Constant arbitrary

-- 
-- 4.
data Optional a = Nada | Yep a deriving (Show, Eq, Ord)

instance Functor Optional where
  fmap _ Nada = Nada
  fmap f (Yep a) = Yep (f a)

instance Applicative Optional where
  pure = Yep
  Yep f <*> m = fmap f m
  Nada <*> _ = Nada

instance Foldable Optional where
  foldMap _ Nada = mempty
  foldMap f (Yep a) = f a

instance Traversable Optional where
  traverse _ Nada = pure Nada
  traverse f (Yep a) = fmap Yep (f a)

instance Arbitrary a => Arbitrary (Optional a) where
  arbitrary = do
    a <- arbitrary
    frequency [(1, return $ Yep a),(2, return Nada)]

instance Eq a =>  EqProp (Optional a) where
  (=-=) = eq
-- 
-- 5.
data List a = Nil | Cons a (List a) deriving (Show, Eq, Ord)

instance Semigroup a => Semigroup (List a)where
  (<>) Nil _  = Nil
  (<>) _ Nil  = Nil
  (<>) (Cons x xs) ys = Cons x $ xs <> ys

instance Monoid a => Monoid (List a) where
  mempty = Cons mempty Nil
  mappend = (<>)

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a la) = Cons (f a) (fmap f la)

instance Foldable List where
  foldMap f Nil = mempty
  foldMap f (Cons a la) = mappend (f a ) (foldMap f la)

instance Traversable List where
  traverse _ Nil = pure Nil
  traverse f (Cons a la) =  fmap Cons (f a) <*> traverse f la
                              -- Cons (a -> a)
                              -- for all we know la could be another (Cons 1 (Cons 2 ..)) or Nil

instance Arbitrary a => Arbitrary (List a) where
  arbitrary  = do
    a <- arbitrary
    b <- arbitrary
    frequency [(1, return Nil), (2, return $ Cons a b)]

instance Eq a => EqProp (List a) where
    (=-=) = eq
-- 
-- 6.
data Three a b c = Three a b c deriving (Show,Eq,Ord)

instance Functor (Three a b) where
    fmap f (Three a b c) = Three a b (f c)

instance Foldable (Three a b) where
  foldMap f (Three a b c) = f c

instance Traversable (Three a b) where
  traverse f (Three a b c) = fmap (Three a b) (f c)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        return $ (Three a b c)
instance (Eq a, Eq b, Eq c) => EqProp (Three a b c) where
    (=-=) = eq

-- 7.
data Pair a b = Pair a b deriving (Show, Eq, Ord)

instance Functor (Pair a) where
  fmap f (Pair a b) = Pair a (f b)

instance Foldable (Pair a) where
  foldMap f (Pair a b) = f b

instance Traversable (Pair a) where
  traverse f (Pair a b) = fmap (Pair a) (f b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Pair a b) where
  arbitrary = Pair <$> arbitrary <*> arbitrary

instance (Eq a, Eq b) => EqProp (Pair a b) where
  (=-=) = eq
-- 8.
data Big a b = Big a b b deriving (Eq, Show, Ord)

instance Functor (Big a ) where
  fmap f (Big a b b') = Big a (f b) (f b')

instance Foldable (Big a) where
  foldMap f (Big _ b b') = f b <> f b'
-- Foldmap must return the Monoid! so use the monoid stuff for folds and applicatives for partial application with fmap on traversables!
instance Traversable (Big a) where
  traverse f (Big a b b') = fmap (Big a) (f b) <*> (f b')

instance Monoid a => Applicative (Big a) where
  pure x = Big mempty x x 
  Big a b c <*> Big a' b' c' = Big (a `mappend` a') (b b') (c c')

instance (Arbitrary a, Arbitrary b) => Arbitrary (Big a b) where
  arbitrary = Big <$> arbitrary <*> arbitrary <*> arbitrary

instance (Eq a, Eq b) => EqProp (Big a b) where
  (=-=) = eq

-- 8.
data Bigger a b = Bigger a b b b deriving (Show,Eq,Ord)

instance Functor (Bigger a) where
  fmap f (Bigger a b b' b'') = Bigger a (f b) (f b') (f b'')

instance Foldable (Bigger a) where
  foldMap f (Bigger _ b b' b'') = f b <> f b' <> f b''

instance Traversable (Bigger a) where
  traverse f (Bigger a b b' b'') = fmap (Bigger a) (f b) <*> (f b') <*> (f b'')

instance (Arbitrary a, Arbitrary b) => Arbitrary (Bigger a b) where
  arbitrary = Bigger <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

instance (Eq a, Eq b) => EqProp (Bigger a b) where
  (=-=) = eq

-- 
-- 9.
data S n a = S (n a) a deriving (Eq, Show)

instance Functor n => Functor (S n) where
  fmap f (S fa a) = S (f <$> fa) (f a)

instance Applicative n => Applicative (S n) where
  pure x = S (pure x) x
  (S fa a) <*> (S as a') = S (fa <*> as) (a a')

instance Foldable n => Foldable (S n) where
  foldMap f (S fa a) = foldMap f fa <> f a

instance Traversable n => Traversable (S n) where
  traverse f (S fa a) = S <$> traverse f fa <*> f a

instance (Applicative n, Testable (n Property), Eq a, Eq (n a), EqProp a) =>
         EqProp (S n a) where
  (=-=) = eq

instance (Functor n, Arbitrary (n a), Arbitrary a) => Arbitrary (S n a) where
  arbitrary = S <$> arbitrary <*> arbitrary
-- 
-- Time for some Binary Trees! 10.

data Tree a = Empty | Leaf a | Node (Tree a) a (Tree a) deriving (Show,Eq)

instance Functor Tree where
  fmap _ Empty = Empty
  fmap f (Leaf a) = Leaf (f a)
  fmap f (Node l a r) = Node (fmap f l) (f a) (fmap f r)

instance Foldable Tree where
  foldMap _ Empty = mempty
  foldMap f (Leaf x) = f x
  foldMap f (Node l a r) = (foldMap f l) <> f a <> (foldMap f r)

instance Traversable Tree where
  traverse _ Empty = pure Empty
  traverse f (Leaf x) = liftA Leaf (f x)
  traverse f (Node l a r) = Node <$> (traverse f l) <*> f a  <*> (traverse f r)

instance Arbitrary a => Arbitrary (Tree a) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    frequency [(1, return Empty), (3, fmap Leaf arbitrary), (2, return $ Node a b c)]
-- you need to account for all the expressions in the type! for example if a type has 3 data contructors you must account for each one. 
-- like shown here above, otherwise the generated data will just be bottom!

instance Eq a => EqProp (Tree a) where
  (=-=) = eq
-- ===========                 ===========
--             Testing Chamber
-- ===========                 =========== 

type BSD = ([Bool],String,(Sum Int))
type FiveTypes = (Int,String,All,(Sum Double),(Product Int))
type TraverseT = ([Bool],[String],Maybe (Sum Int))

expr :: Expr BSD
expr = undefined
exprF :: Expr FiveTypes
exprF = undefined
exprT :: Expr TraverseT
exprT = undefined
-- 
iden :: Identity BSD
iden = undefined
idenF :: Identity FiveTypes
idenF = undefined
idenT :: Identity TraverseT
idenT = undefined
-- 
cons :: Constant BSD BSD
cons = undefined
consF :: Constant String FiveTypes
consF = undefined
consT :: Constant String TraverseT
consT = undefined
-- 
opt :: Optional BSD
opt = undefined
optF :: Optional FiveTypes
optF = undefined
optT :: Optional TraverseT
optT = undefined
-- 
list :: List BSD
list = undefined
listF :: List FiveTypes
listF = undefined
listT :: List TraverseT
listT = undefined
-- 
thr3 :: Three BSD BSD BSD
thr3 = undefined
thr3F :: Three String String FiveTypes
thr3F = undefined
thr3T :: Three String String TraverseT
thr3T = undefined
-- 
pair :: Pair BSD BSD
pair = undefined
pairF :: Pair String FiveTypes
pairF = undefined
pairT :: Pair String TraverseT
pairT = undefined
-- 
big :: Big BSD BSD
big = undefined
bigF :: Big String FiveTypes
bigF = undefined
bigT :: Big String TraverseT
bigT = undefined
-- 
bigr :: Bigger BSD BSD
bigr = undefined
bigrF :: Bigger String FiveTypes
bigrF = undefined
bigrT :: Bigger String TraverseT
bigrT = undefined
-- 
s :: S [] (Int, Int, [Int])
s = undefined
sF :: S [] FiveTypes
sF = undefined
sT :: S [] TraverseT
sT = undefined
-- 
tree = undefined :: Tree BSD
treeF = undefined :: Tree FiveTypes
treeT = undefined :: Tree TraverseT
-- 
main :: IO ()
main = do

  quickBatch (functor expr)
  quickBatch (applicative expr)
  quickBatch (monad expr)
  quickBatch (foldable exprF)
  quickBatch (traversable exprT)
-- 
  quickBatch (functor iden)
  quickBatch (applicative iden)
  quickBatch (foldable idenF)
  quickBatch (traversable idenT)
--
  quickBatch (functor cons)
  quickBatch (applicative cons)
  quickBatch (foldable consF)
  quickBatch (traversable consT)
-- 
  quickBatch (functor opt)
  quickBatch (applicative opt)
  quickBatch (foldable optF)
  quickBatch (traversable optT)
-- 
  quickBatch (functor list)
  quickBatch (foldable listF)
  quickBatch (traversable listT)
-- 
  quickBatch (functor thr3)
  quickBatch (foldable thr3F)
  quickBatch (traversable thr3T)
-- 
  quickBatch (functor pair)
  quickBatch (foldable pairF)
  quickBatch (traversable pairT)
-- 
  quickBatch (functor big)
  quickBatch (applicative big)
  quickBatch (foldable bigF)
  quickBatch (traversable bigT)
--
  quickBatch (functor bigr)
  quickBatch (foldable bigrF)
  quickBatch (traversable bigrT)
-- 
  quickBatch (functor s)
  quickBatch (foldable sF)
  quickBatch (traversable sT)
-- 
  quickBatch (functor tree)
  quickBatch (foldable treeF)
  quickBatch (traversable treeT)
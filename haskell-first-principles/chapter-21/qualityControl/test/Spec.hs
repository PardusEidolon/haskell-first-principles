module Main where

import Test.QuickCheck
import Test.QuickCheck.Checkers 
import Test.QuickCheck.Classes
import Data.Monoid

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

type BSD = ([Bool],String,(Sum Int))
type FiveTypes = (Int,String,All,(Sum Double),(Product Int))
type TraverseMe = ([Bool],[String],Maybe (Sum Int))
-- type T = (f a, g b, c, m)

expr :: Expr BSD
expr = undefined

exprF :: Expr FiveTypes
exprF = undefined

exprT :: Expr TraverseMe
exprT = undefined


main :: IO ()
main = do
  quickBatch (monoid expr)
  quickBatch (functor expr)
  quickBatch (applicative expr)
  quickBatch (monad expr)
  quickBatch (foldable exprF)
  quickBatch (traversable exprT)
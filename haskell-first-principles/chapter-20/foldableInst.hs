module FolableInst where

import Data.Foldable

newtype Identity a = Identity a deriving Show

instance Semigroup a => Semigroup (Identity a) where
    (<>) (Identity a) (Identity b) = Identity (a <> b)

instance Monoid a => Monoid (Identity a) where
    mempty  = Identity mempty
    mappend = (<>)

instance Functor Identity where
    fmap f (Identity a) = Identity (f a)

instance Applicative Identity where
    pure = Identity
    (<*>) (Identity f) (Identity a) = Identity (f a)

instance Monad Identity where
    return = pure
    (>>=) (Identity a) f = f a

instance Foldable Identity where
    foldr f b (Identity a) = f a b
    foldl f b (Identity a) = f b a
    foldMap f (Identity a) = f a


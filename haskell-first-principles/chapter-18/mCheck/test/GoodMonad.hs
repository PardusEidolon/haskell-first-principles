module GoodMonad where

import Test.QuickCheck
import Test.QuickCheck.Checkers 
import Test.QuickCheck.Classes

data CountMe' a = CountMe' Integer a deriving (Eq,Show)

instance Semigroup a => Semigroup (CountMe' a) where
    (<>) (CountMe' n a) (CountMe' n' a') = CountMe' (n + n') (a <> a') 

instance Monoid a => Monoid (CountMe' a) where
    mempty = CountMe' 0 mempty
    mappend =  (<>)

instance Functor CountMe' where
    fmap f (CountMe' i a) = CountMe' i (f a)

instance Applicative CountMe' where
    pure = CountMe' 0
    (<*>) (CountMe' i f) (CountMe' i' a) = CountMe' (i + i') (f a)

instance Monad CountMe' where
    return = pure
    (>>=) (CountMe' i a) f = 
        let (CountMe' i' a') = f a
        in CountMe' (i + i') a'

instance Eq a =>EqProp (CountMe' a) where 
    (=-=) = eq

instance Arbitrary a => Arbitrary (CountMe' a) where 
    arbitrary = CountMe' <$> arbitrary <*> arbitrary

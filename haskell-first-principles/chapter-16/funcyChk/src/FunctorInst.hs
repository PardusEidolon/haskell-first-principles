module FunctorInst where

import Test.QuickCheck

newtype Identity a =Identity a deriving (Show, Eq)

data Pair a = Pair a a deriving (Show, Eq)
data Two a b =Two a b deriving (Show, Eq)
data Three a b c = Three a b c deriving (Show, Eq)
data Three' a b = Three' a b b deriving (Show, Eq)
data Four a b c d = Four a b c d deriving (Show, Eq)
data Four' a b = Four' a a a b deriving (Show, Eq)
data Trivial = Trivial deriving (Show, Eq)

-- Identity Instance
instance Functor Identity where
    fmap f (Identity a) = Identity (f a)

instance (Arbitrary a) => Arbitrary (Identity a) where
    arbitrary = do
        a <- arbitrary
        return $ (Identity a)
-- =================

-- Pair Instance
instance Functor Pair where
    fmap f (Pair a a') = Pair (f a) (f a')

instance (Arbitrary a) => Arbitrary (Pair a) where
    arbitrary = do
        a <- arbitrary
        a' <- arbitrary
        return $ (Pair a a')
-- =================

-- Two Instance
instance Functor (Two a) where
    fmap f (Two a b) = Two a (f b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        return $ (Two a b)
-- =================

-- Three Instance
instance Functor (Three a b) where
    fmap f (Three a b c) = Three a b (f c)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        return $ (Three a b c)
-- =================

-- Three Prime Instance
instance Functor (Three' a) where
    fmap f (Three' a b b') = Three' a (f b) (f b')

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        return $ (Three' a b c)
-- =================

-- Four Instance
instance Functor (Four a b c) where
    fmap f (Four a b c d) = Four a b c (f d)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        d <- arbitrary
        return $ (Four a b c d)
-- =================

-- Four Prime Instance
instance Functor (Four' a ) where
    fmap f (Four' a a' a'' b) = Four' a a' a'' (f b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        d <- arbitrary
        return $ (Four' a b c d)
-- =================

-- Trivial Instance
-- Functor instance wont work, theres no value to transform it doesnt even take an argument
-- =================

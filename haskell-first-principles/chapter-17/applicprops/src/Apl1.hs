module Apl1 where
    
import Data.Monoid 
import Control.Applicative
import Test.QuickCheck
import Test.QuickCheck.Checkers 
import Test.QuickCheck.Classes

-- Book - bad Version 

-- instance Monoid a => Monoid (ZipList a) where 
--     mempty = pure mempty
--     mappend = liftA2 mappend

-- instance Semigroup a => Semigroup (ZipList a) where
--     (<>) (ZipList []) (ZipList []) = (ZipList [])
--     (<>) _      (ZipList b) = (ZipList b)
--     (<>) (ZipList a) _ = (ZipList a)
--     (<>) (ZipList a) (ZipList b) = (ZipList (mappend a b))

-- instance Eq a => EqProp (ZipList a) where
--     (=-=) = eq

-- foo = ZipList [Sum 1]
-- baz = ZipList [Sum 2]

-- types Sum and ZipList already have quickcheck Arbitrary instances.

-- sumGen :: Gen (Sum Int)
-- sumGen = arbitrary

-- oke I make a functional type now

data Yay a = Yay a | Nay deriving (Eq,Show)

instance Monoid a => Monoid (Yay a) where
    mempty = Nay
    mappend = (<>)

instance Semigroup a => Semigroup (Yay a) where
    (<>) (Yay a) (Yay b) = Yay (a <> b)
    (<>) _ (Yay a) = (Yay a) 
    (<>) (Yay b) _ = (Yay b)
    (<>) Nay Nay = Nay

instance Functor Yay where
    fmap f (Yay a) = Yay (f a)
    fmap f _ = Nay

instance Applicative Yay where
    pure = Yay
    (<*>) (Yay f) (Yay a) = Yay (f a)
    (<*>) _       (Yay a) = Nay
    (<*>) (Yay f) _       = Nay
    (<*>)  Nay    Nay     = Nay

instance Arbitrary a => Arbitrary (Yay a) where
    arbitrary = do 
        a <- arbitrary
        frequency [(1,return Nay),(2,return $ Yay a)]

instance Eq a => EqProp (Yay a) where
    (=-=) = eq

-- wrapped instances
newtype Wrapped a = Wrapped (Yay a) deriving (Eq,Show)

instance Monoid a => Monoid (Wrapped a) where
    mempty = Wrapped Nay
    mappend = (<>)

instance Semigroup a => Semigroup (Wrapped a) where
    (<>) (Wrapped (fa)) (Wrapped (fb)) = Wrapped (fa <> fb)

instance Functor Wrapped where
    fmap f (Wrapped a) = Wrapped (fmap f a)

instance Applicative Wrapped where
    pure a = Wrapped (Yay a)
    (<*>) (Wrapped f) (Wrapped a) = Wrapped (f <*> a)

instance Arbitrary a => Arbitrary (Wrapped a) where
    arbitrary = do 
        a <- arbitrary
        frequency [(1,return $ Wrapped Nay),(2,return $ Wrapped (Yay a))]

instance Eq a => EqProp (Wrapped a) where
    (=-=) = eq

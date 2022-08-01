module SemigroupInst where

import qualified Test.QuickCheck as Q
import Data.Monoid
import Control.Monad

-- this has inadvertently become the exercise file

data Two a b = Two a b deriving (Eq,Show)

data Three a b c = Three a b c deriving (Eq,Show)

data Four a b c d = Four a b c d deriving (Eq,Show)

data Or a b = Fst a | Snd b deriving (Eq,Show)

data Validation a b = Failure a | Success b deriving (Eq,Show)

newtype Identity a = Identity a deriving (Eq,Show)

newtype BoolConj = BoolConj Bool deriving (Eq,Show)

newtype BoolDisj = BoolDisj Bool deriving (Eq,Show)

newtype Combine a b = Combine { unCombine :: (a -> b) }

newtype Comp a = Comp { unComp :: (a -> a) }

instance Semigroup a => Semigroup (Validation a b) where
    _         <> Success a = Success a
    Success b <> _         = Success b
    Failure a <> Failure b = Failure (a <> b)

instance Semigroup a => Semigroup (Identity a) where
    Identity a <> Identity b = Identity $ a <> b

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
    (Two a b) <> (Two a' b') = Two (a <> a') (b <> b')

instance (Semigroup a, Semigroup b,Semigroup c) => Semigroup (Three a b c) where
    (Three a b c) <> (Three a' b' c') = Three (a <> a') (b <> b') (c <> c')

instance (Semigroup a, Semigroup b,Semigroup c, Semigroup d) => Semigroup (Four a b c d) where
    (Four a b c d) <> (Four a' b' c' d') = Four (a <> a') (b <> b') (c <> c') (d <> d')

instance Semigroup BoolConj where
    (BoolConj True) <> (BoolConj True) = BoolConj True
    _               <> _               = BoolConj False

instance Semigroup BoolDisj where
    (BoolDisj True) <> (BoolDisj True) = BoolDisj True
    _               <> _               = BoolDisj False

instance (Semigroup a, Semigroup b) => Semigroup (Or a b) where
    (Snd b) <> _       = Snd b
    _       <> (Snd b) = Snd b
    _       <> (Fst a) = Fst a

instance (Semigroup b) => Semigroup (Combine a b) where
    (Combine f) <> (Combine g) = Combine (\a -> f a <> g a) -- it takes something as an argument to both functions?

instance (Semigroup a) => Semigroup (Comp a) where
    (Comp f) <> (Comp g) = Comp (\a -> f a <> g a)

instance (Monoid a) => Monoid (Comp a) where
    mempty  = Comp mempty
    mappend = (<>)

instance (Monoid b) => Monoid (Combine a b) where
    mempty  = Combine $ const mempty
    mappend = (<>)

instance Monoid BoolConj where
    mempty  = BoolConj False
    mappend = (<>)

instance Monoid BoolDisj where
    mempty  = BoolDisj False
    mappend = (<>)

instance (Q.CoArbitrary a, Q.Arbitrary b) => Q.Arbitrary (Combine a b) where
    arbitrary = Combine <$> Q.arbitrary

instance (Q.CoArbitrary a,Q.Arbitrary a) => Q.Arbitrary (Comp a) where
    arbitrary = Comp <$> Q.arbitrary

instance Q.Arbitrary a => Q.Arbitrary (Identity a) where
    arbitrary = do
        a <- Q.arbitrary
        return $ Identity a

instance (Q.Arbitrary a,Q.Arbitrary b) => Q.Arbitrary (Two a b) where
    arbitrary = do
        a <- Q.arbitrary
        b <- Q.arbitrary
        return $ Two a b

instance (Q.Arbitrary a,Q.Arbitrary b,Q.Arbitrary c) => Q.Arbitrary (Three a b c) where
    arbitrary = do
        a <- Q.arbitrary
        b <- Q.arbitrary
        c <- Q.arbitrary
        return $ Three a b c

instance (Q.Arbitrary a,Q.Arbitrary b,Q.Arbitrary c,Q.Arbitrary d) => Q.Arbitrary (Four a b c d) where
    arbitrary = do
        a <- Q.arbitrary
        b <- Q.arbitrary
        c <- Q.arbitrary
        d <- Q.arbitrary
        return $ Four a b c d


instance (Q.Arbitrary a, Q.Arbitrary b) => Q.Arbitrary (Or a b) where
    arbitrary = do
        a <- Q.arbitrary
        b <- Q.arbitrary
        Q.oneof [return $ Fst a, 
               return $ Snd b]

instance (Q.Arbitrary a, Q.Arbitrary b) => Q.Arbitrary (Validation a b) where
    arbitrary = do
        a <- Q.arbitrary
        b <- Q.arbitrary
        Q.oneof [return $ Failure a, 
               return $ Success b]

instance Show (Combine a b) where
    show (Combine _) = "Combine"

instance Show (Comp a) where
    show (Comp _) = "Comp"

type IdenAssoc a = Identity a -> Identity a -> Identity a -> Bool 
type TwoAssoc a b = Two a b -> Two a b -> Two a b -> Bool
type ThreeAssoc a b c = Three a b c -> Three a b c -> Three a b c -> Bool
type FourAssoc a b c d = Four a b c d -> Four a b c d -> Four a b c d -> Bool
type CombAssoc a b = Combine a b -> Combine a b -> Combine a b -> a -> Bool
type CompAssoc a = Comp a -> Comp a -> Comp a -> a -> Bool
type CompIden a = Comp a -> a -> Bool
type OrAssoc a b = Or a b -> Or a b -> Or a b -> Bool
type ValidAssoc a b = Validation a b -> Validation a b -> Validation a b -> Bool
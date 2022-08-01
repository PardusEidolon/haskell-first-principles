module MonoidExercises where

import qualified Test.QuickCheck as Q
import SemigroupInst
import Data.Monoid
import Control.Monad

data Trivial = Trivial deriving (Eq, Show)

newtype Mem s a = Mem { runMem :: s -> (a,s) }

instance Show (Mem a b ) where
    show (Mem _) = "Mem"
instance Semigroup Trivial where 
    _ <> _ = Trivial

instance Semigroup a => Semigroup (Mem s a) where
    (Mem f) <> (Mem g) = 
        Mem $ \s -> 
            let (a',s') = g s
                (a'',s'') = f s'
            
            in  (a'' <> a',s'')

instance Monoid a => Monoid (Mem s a) where
    mempty = Mem $ \s -> (mempty,s)
    mappend = (<>)

instance Monoid Trivial where
    mempty = Trivial
    mappend = (<>)

instance Q.Arbitrary Trivial where
    arbitrary = return Trivial

instance (Q.CoArbitrary s, Q.Arbitrary a, Q.Arbitrary s ) => Q.Arbitrary (Mem s a) where
    arbitrary = Mem <$> Q.arbitrary

type TrivAssoc = Trivial -> Trivial -> Trivial -> Bool
type MemAssoc s a = Mem s a -> Mem s a -> Mem s a -> s -> Bool
type MemId a b = Mem a b -> a -> Bool
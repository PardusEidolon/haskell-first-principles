module Tests where

import Test.QuickCheck
import Test.Hspec
import MaybeAnotherMonoid
import qualified SemigroupInst as Semi
import Testy
import MonoidExercises
import Data.Monoid
import Control.Monad


main :: IO ()
main = do
    quickCheck (monoidAssoc :: BullMappend)
    quickCheck (monoidLeftIdentity :: Bull -> Bool)
    quickCheck (monoidRightIdentity :: Bull -> Bool)
    quickCheck (semigroupAssoc :: TrivAssoc)
    quickCheck (monoidLeftIdentity :: Trivial -> Bool)
    quickCheck (monoidRightIdentity :: Trivial -> Bool)
    quickCheck (semigroupAssoc :: Semi.IdenAssoc String)
    quickCheck (semigroupAssoc :: Semi.TwoAssoc (Sum Int) String)
    quickCheck (semigroupAssoc :: Semi.ThreeAssoc (Sum Int) String [Bool])
    quickCheck (semigroupAssoc :: Semi.FourAssoc (Sum Int) String [Bool] (Product Int))
    quickCheck (monoidAssoc :: FirstMappend)
    quickCheck (monoidLeftIdentity :: FirstID)
    quickCheck (monoidRightIdentity :: FirstID)
    quickCheck (combAssoc :: Semi.CombAssoc Float (Product Int))
    quickCheck (compAssoc :: Semi.CompAssoc (Sum Int))
    quickCheck (compIdentityLeft :: Semi.CompIden (Sum Int))
    quickCheck (compIdentityRight :: Semi.CompIden (Sum Int))
    quickCheck (semigroupAssoc :: Semi.OrAssoc (Sum Int) String)
    quickCheck (semigroupAssoc :: Semi.ValidAssoc String (Sum Int))
    quickCheck (memAssoc :: MemAssoc Int String)
    quickCheck (memIdentityRight :: MemId Int String)
    quickCheck (memIdentityLeft :: MemId Int String)

main' :: IO ()
main' = do
    let 
        failure :: String -> Semi.Validation String Int
        failure = Semi.Failure
        success :: Int -> Semi.Validation String Int
        success = Semi.Success
    print $ success 1 <> failure "blah"
    print $ success 1 <> success 2
    print $ failure "woot" <> failure "blah"
    print $ failure "yeet" <> success 2

mainy :: IO ()
mainy = do
    let 
        rmz = runMem mempty 0
        rmr = runMem (memoryLane <> mempty) 0
        rml = runMem (mempty <> memoryLane) 0
    print $ (rmz :: (String , Int))
    print $ rmr
    print $ rml
    print $ rml == runMem memoryLane 0
    print $ rmr == runMem memoryLane 0 

monoidAssoc :: (Eq m, Monoid m) => m -> m -> m ->Bool 
monoidAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

monoidLeftIdentity :: (Eq m, Monoid m) => m -> Bool
monoidLeftIdentity a = (mempty <> a) == a

monoidRightIdentity :: (Eq m, Monoid m) => m -> Bool
monoidRightIdentity a = (a <> mempty) == a

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

combAssoc :: (Eq b, Semigroup b) => Semi.Combine a b -> Semi.Combine a b -> Semi.Combine a b -> a -> Bool
combAssoc f g h a = Semi.unCombine (f <> (g <> h )) a == Semi.unCombine ((f <> g) <> h ) a

compAssoc :: (Eq a, Semigroup a) => Semi.Comp a -> Semi.Comp a -> Semi.Comp a -> a -> Bool
compAssoc f g h a = Semi.unComp (f <> (g <> h )) a == Semi.unComp ((f <> g) <> h ) a

memAssoc :: (Eq a, Eq b, Monoid b) => Mem a b -> Mem a b -> Mem a b -> a -> Bool
memAssoc f g h a = runMem (f <> (g <> h )) a == runMem ((f <> g) <> h ) a

memIdentityRight :: (Eq a, Eq b, Monoid b) => Mem a b -> a -> Bool
memIdentityRight f a = runMem (f <> mempty) a == runMem f a

memIdentityLeft :: (Eq a, Eq b, Monoid b) => Mem a b -> a -> Bool
memIdentityLeft f a = runMem (mempty <> f ) a == runMem f a

compIdentityLeft :: (Eq a, Monoid a) => Semi.Comp a -> a -> Bool
compIdentityLeft f a = Semi.unComp (f <> mempty) a == Semi.unComp f a

compIdentityRight :: (Eq a, Monoid a) => Semi.Comp a -> a -> Bool
compIdentityRight f a = Semi.unComp (mempty <> f) a == Semi.unComp f a

memoryLane :: Num a => Mem a String 
memoryLane = Mem $ \s -> ("hello",s + 1)
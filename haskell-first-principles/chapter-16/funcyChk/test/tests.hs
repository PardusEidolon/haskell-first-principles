{-# LANGUAGE ViewPatterns #-}
module Main where

import Test.QuickCheck
import Test.QuickCheck.Function
import Test.Hspec
import FunctorInst

type Fint = Fun Int Int
type IntFC = Maybe Int -> Fint -> Fint -> Bool
type PropPair = Pair Int -> Fint -> Fint -> Bool
type PropId = Identity Int -> Fint -> Fint -> Bool
type PropThree = Three String Char Int -> Fint -> Fint -> Bool
type PropThreePrime = Three' String Int -> Fint -> Fint -> Bool
type PropFour = Four String Char Float Int -> Fint -> Fint -> Bool
type PropFourPrime = Four' Float Int -> Fint -> Fint -> Bool

functorIdentity :: (Functor f, Eq (f a)) => f a -> Bool
functorIdentity f = fmap id f == f

functorCompose :: (Functor f, (Eq (f c))) => (a -> b) -> (b -> c) -> f a -> Bool
functorCompose f g x = (fmap g (fmap f x)) == (fmap (g . f) x)

functorCompose' :: (Functor f, (Eq (f c))) => f a -> Fun a b -> Fun b c -> Bool
functorCompose' x (Fun _ f) (Fun _ g) = (fmap (g . f) x) == (fmap g . fmap f $ x)

foo :: [Int] -> Bool
foo x = functorIdentity x

bar :: [Int] -> Bool
bar x = functorCompose (+1) (*2) $ x

baz :: IntFC
baz x = functorCompose' x

prop_pair_comp :: PropPair
prop_pair_comp x = functorCompose' x

prop_pair_id :: Pair Int -> Bool
prop_pair_id x = functorIdentity x

prop_identity_comp :: PropId
prop_identity_comp x = functorCompose' x

prop_identity_id :: Identity Int -> Bool
prop_identity_id x = functorIdentity x

prop_three_Comp :: PropThree
prop_three_Comp x = functorCompose' x

prop_three_id :: Three String Char Int -> Bool
prop_three_id x = functorIdentity x

prop_three'_comp :: PropThreePrime
prop_three'_comp x = functorCompose' x

prop_three'_id :: Three' String Int -> Bool
prop_three'_id x = functorIdentity x

prop_four_comp :: PropFour
prop_four_comp x = functorCompose' x

prop_four_id :: Four String Char Float Int -> Bool
prop_four_id x = functorIdentity x

prop_four'_comp :: PropFourPrime
prop_four'_comp x = functorCompose' x

prop_four'_id :: Four' Float Int -> Bool
prop_four'_id x = functorIdentity x
-- ===================
--   __ _  ___ _(_)__ 
--  /  ' \/ _ `/ / _ \
-- /_/_/_/\_,_/_/_//_/
-- ====================

main :: IO ()
main = hspec $ do
    describe "QuickCheck Functors" $ 
        do it "Should be all true from a certain point of view" $
            do
                quickCheck prop_pair_comp
                quickCheck prop_pair_id
-- ========================
                quickCheck prop_identity_comp
                quickCheck prop_identity_id
-- ========================
                quickCheck prop_three_Comp
                quickCheck prop_three_id
-- ========================
                quickCheck prop_three'_comp
                quickCheck prop_three'_id
-- ========================
                quickCheck prop_four_comp
                quickCheck prop_four_id
-- ========================
                quickCheck prop_four'_comp
                quickCheck prop_four'_id
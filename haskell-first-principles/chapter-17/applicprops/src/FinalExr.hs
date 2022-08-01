module FinalExr(main) where

import Data.Monoid
import Control.Applicative
import Test.QuickCheck 
import Test.QuickCheck.Checkers 
import Test.QuickCheck.Classes

type BPS = ([Bool],Product Float,Sum Int)

-- 1.
data Pair a = Pair a a deriving (Eq,Show)

instance Functor Pair where
    fmap f (Pair a a') = Pair (f a) (f a')

instance Applicative Pair where
    pure a = Pair a a
    (<*>) (Pair f fs) (Pair x xs) = Pair (f x) (fs xs)

instance Arbitrary a => Arbitrary (Pair a) where
    arbitrary = do
        a <- arbitrary
        Pair a <$> arbitrary

instance Eq a => EqProp (Pair a) where
    (=-=) = eq

-- 2.
data Two a b = Two a b deriving (Eq,Show)

instance Functor (Two a) where
    fmap f (Two a b) = Two a (f b)

instance Monoid a => Applicative (Two a) where
    pure a = Two mempty a
    (<*>) (Two as f) (Two a b) = Two (as `mappend` a) (f b) 

instance (Arbitrary a,Arbitrary b) => Arbitrary (Two a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        return $ Two a b

instance (Eq a, Eq b) => EqProp (Two a b) where
    (=-=) = eq

-- 3.
data Three a b c = Three a b c deriving (Eq,Show)

instance Functor (Three a b) where
    fmap f (Three a b c) = Three a b (f c)

instance (Monoid a,Monoid b) => Applicative (Three a b) where
    pure a = Three mempty mempty a
    (<*>) (Three a' b' f) (Three a b c) = Three (a' `mappend` a) (b' `mappend` b) (f c)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        return $ Three a b c

instance (Eq a, Eq b, Eq c) => EqProp (Three a b c) where
    (=-=) = eq

-- 4.
data Three' a b = Three' a b b deriving (Eq,Show)

instance Functor (Three' a) where
    fmap f (Three' a b b' ) = Three' a (f b) (f b')

instance Monoid a => Applicative (Three' a) where
    pure a = Three' mempty a a
    (<*>) (Three' x f f') (Three' xs ys zs) = Three' (x `mappend` xs) (f  ys) (f' zs) 

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        return $ Three' a b b

instance (Eq a, Eq b) => EqProp (Three' a b) where
    (=-=) = eq

-- 5.
data Four a b c d = Four a b c d deriving (Eq,Show)

instance Functor (Four a b c) where
    fmap f (Four a b c d) = Four a b c (f d)

instance (Monoid a,Monoid b,Monoid c) => Applicative (Four a b c) where
    pure = Four mempty mempty mempty
    (<*>) (Four a b c f) (Four a' b' c' fs) = Four (a `mappend` a')
                                                 (b `mappend` b')
                                                 (c `mappend` c')
                                                 (f fs)
instance (Arbitrary a,Arbitrary b,Arbitrary c,Arbitrary d) => Arbitrary (Four a b c d) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        d <- arbitrary
        return $ Four a b c d

instance (Eq a, Eq b, Eq c, Eq d) => EqProp (Four a b c d) where
    (=-=) = eq

-- 6.
data Four' a b = Four' a a a b deriving (Eq,Show)

instance Functor (Four' a) where
    fmap f (Four' a a' a'' b) = Four' a a' a'' (f b)

instance Monoid a => Applicative (Four' a) where
    pure = Four' mempty mempty mempty
    (<*>) (Four' f f' f'' a) (Four' x xs ys as) = Four' (f `mappend` x) (f' `mappend` xs) (f'' `mappend` ys) (a as)

instance (Arbitrary a,Arbitrary b) => Arbitrary (Four' a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        return $ Four' a a a b

instance (Eq a, Eq b) => EqProp (Four' a b) where
    (=-=) = eq
-- ====================================

-- 1.a
fPair :: Pair BPS
fPair = undefined

aPair :: Pair BPS
aPair = undefined

-- 2.b
fTwo :: Two String BPS
fTwo = undefined

aTwo :: Two String BPS
aTwo = undefined

-- 3.c
fThree :: Three String Any BPS
fThree = undefined

aThree :: Three String Any BPS
aThree = undefined

-- 4.d
fThree' :: Three' Any BPS
fThree' = undefined

aThree' :: Three' Any BPS
aThree' = undefined

-- 5.e
fFour :: Four String String Any BPS
fFour = undefined

aFour :: Four String String Any BPS
aFour = undefined

-- 6.f
fFour' :: Four' String  BPS
fFour' = undefined

aFour' :: Four' String  BPS
aFour' = undefined

-- Tests will import into spec soon

main :: IO ()
main = do
    putStrLn "Pairs"
    quickBatch $ functor fPair
    quickBatch $ applicative aPair

    putStrLn "Twos"
    quickBatch $ functor fTwo
    quickBatch $ applicative aTwo

    putStrLn "Threes"
    quickBatch $ functor fThree
    quickBatch $ applicative aThree

    putStrLn "Three Prime"
    quickBatch $ functor fThree'
    quickBatch $ applicative aThree'
    
    putStrLn "Four"
    quickBatch $ functor fFour
    quickBatch $ applicative aFour

    putStrLn "Four Prime"
    quickBatch $ functor fFour'
    quickBatch $ applicative aFour'
module Lib where

import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes
import Control.Monad
import Control.Applicative

-- 1.
data Nope a = NopeDotJpg deriving (Show,Eq)

instance Functor Nope where
    fmap _ a = NopeDotJpg

instance Applicative Nope where
    pure _ = NopeDotJpg
    (<*>) _ NopeDotJpg = NopeDotJpg

instance Monad Nope where
    return = pure
    (>>=) _ _ = NopeDotJpg

instance Arbitrary a => Arbitrary (Nope a) where
    arbitrary = return NopeDotJpg

instance Eq a => EqProp (Nope a) where
    (=-=) = eq

-- 
-- 2.
-- 
data PhhhbbtttEither b a = Left' a | Right' b deriving (Show,Eq)

instance Functor (PhhhbbtttEither b) where
    fmap _ (Right' b) = Right' b
    fmap f (Left' a) = Left' (f a)
instance Applicative (PhhhbbtttEither b) where
    pure = Left'
    (<*>) (Right' a) _ = Right' a
    (<*>) _ (Right' b) = Right' b
    (<*>) (Left' f) (Left' fs) = Left' (f fs)

instance Monad (PhhhbbtttEither b) where
    return = pure
    (Left' a)  >>=  f = f a
    (Right' b) >>= _ = Right' b

instance (Arbitrary a, Arbitrary b) => Arbitrary (PhhhbbtttEither b a) where
    arbitrary = frequency [(1, Right' <$> arbitrary),(3, Left' <$> arbitrary)]

instance (Eq a, Eq b) => EqProp (PhhhbbtttEither b a) where
    (=-=)= eq

-- 
-- 3.
-- 
newtype Identity a = Identity a deriving (Eq, Ord, Show)

instance Functor Identity where
    fmap f (Identity a) = Identity (f a)

instance Applicative Identity where
    pure = Identity
    (<*>) (Identity f) (Identity fs) = Identity (f fs)

instance Monad Identity where
    return = pure
    (Identity a) >>= f = f a

instance Arbitrary a => Arbitrary (Identity a) where
    arbitrary = Identity <$> arbitrary

instance Eq a => EqProp (Identity a) where
    (=-=) = eq

-- 
-- 4.
-- 
data List a = Nil | Cons a (List a) deriving (Show,Eq)

append :: List a -> List a -> List a
append Nil ys = ys
append (Cons x xs) ys = Cons x $ append xs ys

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a la) = Cons (f a) (fmap f la)

instance Applicative List where
  pure a = Cons a Nil
  (<*>) _  Nil = Nil
  (<*>) Nil  _ = Nil
  (<*>) (Cons f fs) as = append (fmap f as) (fs <*> as)

instance Monad List where
  return = pure
  Nil >>= _   = Nil
  (Cons a as) >>= f = append (f a) (as >>= f)

instance Arbitrary a => Arbitrary (List a) where
  arbitrary  = do
    a <- arbitrary
    b <- arbitrary
    frequency [(1, return Nil), (2, Cons <$> (return a) <*> (return b))]

instance Eq a => EqProp (List a) where
    (=-=) = eq

-- List values

foo :: List Int
foo = Cons 1 (Cons 2 Nil)

bar :: List Int
bar = Cons 3 (Cons 4 Nil)

-- 
-- Writing Mondaic Functoral Functions
-- 1.

j :: Monad m => m (m a) -> m a
j m = m >>= id

-- 
-- 2.

l1 :: Monad m => (a -> b) -> m a -> m b
l1 f m = m >>= return . f

-- 
-- 3. 

l2 :: Monad m => (a -> b -> c) -> m a -> m b -> m c
l2 f m1 m2 = m1 >>= (\x -> m2 >>= (return . f x))

-- l2' :: Monad m => (a -> b -> c) -> m a -> m b -> m c
-- l2' f m1 m2 = fmap f m1 <*> m2

--
-- 4.

a :: Monad m => m a -> m (a -> b) -> m b
a m mf = m >>= (\a -> mf >>= \f -> return $ f a)
-- a key thing is here is that were binding values out of the structure to variables then return at the end

-- 
-- 5.
-- Use recursion for this one

meh :: Monad m => [a] -> (a -> m b) -> m [b]
meh [] _ =  return []
meh (x:xs) f = f x >>= \a -> (meh xs f) >>= \b -> return $ a : b

meh' :: Monad m => [a] -> (a -> m b) -> m [b]
meh' [] _ =  return []
meh' (x:xs) f = l2 (:) (f x) (meh xs f)

-- 
-- 6.
-- flip it out yo

flipType :: Monad m => [m a] -> m [a]
flipType m = meh m id
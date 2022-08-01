module Possibilities where

data Possibly a = LolNope | Yeeters a deriving (Eq,Show)

data Sum a b = First a | Second b deriving (Eq,Show)


instance Functor (Sum a) where
    fmap _ (First a) = First a
    fmap f (Second b) = Second (f b)

-- we cant apply a function to the first constructor as all types that works with functor must have a kind of * -> * not * -> * -> *
-- also the fact that the first argument will always be apart of the functor instnace structure when doing instances with functor making it right associative, naturally.

instance Functor Possibly where
    fmap _ LolNope = LolNope
    fmap f (Yeeters a) = Yeeters (f a)

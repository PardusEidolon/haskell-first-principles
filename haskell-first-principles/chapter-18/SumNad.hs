module SumNad where

data Sum a b = First a | Second b deriving (Eq,Show)

instance Functor (Sum a) where
    fmap f (First a) = First a
    fmap f (Second b) = Second (f b)

instance Applicative (Sum a) where
    pure = Second
    (<*>) _ (First b) = First b
    (<*>) (First a) _ = First a
    (<*>) (Second f) (Second fs) = Second (f fs)

instance Monad (Sum a) where
    return = pure
    (Second a) >>= f = f a -- (-> f b)
    (First b) >>= _ = First b

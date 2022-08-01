module MaybeAnotherMonoid where

import Test.QuickCheck
import Data.Monoid
import Control.Monad

type FirstMappend = First' String -> First' String -> First' String -> Bool
type FirstID      = First' String -> Bool

data Optional a = 
      Nada
    | Only a
    deriving (Eq,Show)

newtype First' a = First' { getFirst' :: Optional a } deriving (Eq, Show)

instance Arbitrary a => Arbitrary (Optional a) where
    arbitrary = do
        a <- arbitrary
        frequency [(1,return $ Nada),
                   (1,return $ Only a)]

instance Arbitrary a => Arbitrary (First' a) where
    arbitrary = do
        a <- arbitrary
        frequency [(1,return $ First' Nada),
                   (3,return $ First' (Only a))]

instance Semigroup (First' a) where
    (<>) (First' (Only a)) (First' _) = First' (Only a)
    (<>) (First' _ ) (First' (Only b)) = First' (Only b)
    (<>) (First' _) (First' _) = First' Nada

instance Monoid (First' a) where 
    mempty = First' Nada 
    mappend = (<>)

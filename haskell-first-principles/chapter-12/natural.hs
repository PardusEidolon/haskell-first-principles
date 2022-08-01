module ItsOnlyNatural where

import Data.Maybe

-- Defining Types
data Nat = 
    Zero
  | Succ Nat
  deriving (Eq,Show)


natToInteger :: Nat -> Integer 
natToInteger Zero = 0
natToInteger (Succ n) = natToInteger n + 1

integerToNat :: Integer -> Maybe Nat
integerToNat n 
    | n == 0 = Just Zero
    | n  > 0 = Just . Succ . fromJust . integerToNat $ n - 1
    | otherwise = Nothing 
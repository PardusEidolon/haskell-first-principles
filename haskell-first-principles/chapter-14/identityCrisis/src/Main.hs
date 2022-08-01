module Main where

import Test.QuickCheck
import Test.QuickCheck.Gen (oneof)
import Data.Maybe (Maybe)


data Identity a = Identity a deriving (Eq,Show)
data Pair a b   = Pair a b deriving (Eq,Show)
data Sum  a b   = First a | Second b deriving (Eq,Show)

-- instance Arbitrary a =>
--          Arbitrary (Identity a) where
--   arbitrary = identityGen

main :: IO [Identity Int]
main = do
  sample' identityGenInt
  sample' (identityGen :: Gen (Identity Int))

identityGen :: Arbitrary a => Gen (Identity a)
identityGen = do
  a <- arbitrary
  return (Identity a)

pairGen :: (Arbitrary a, Arbitrary b) => Gen (Pair a b)
pairGen = do
  a <- arbitrary
  b <- arbitrary
  return (Pair a b)

sumGenEqual :: (Arbitrary a, Arbitrary b) => Gen (Sum a b)
sumGenEqual = do
  a <- arbitrary
  b <- arbitrary
  oneof [return $ First a, 
         return $ Second b]
sumGenFirsts :: (Arbitrary a, Arbitrary b) => Gen (Sum a b)
sumGenFirsts = do
  a <- arbitrary
  b <- arbitrary
  frequency [(10,return $ First a), 
         (1,return $ Second b)]

identityGenInt :: Gen (Identity Int)
identityGenInt = identityGen

identityGenChar :: Gen (Identity Char)
identityGenChar = identityGen

identityGenFloat :: Gen (Identity Float)
identityGenFloat = identityGen

pairGenIntChar :: Gen (Pair Int Char)
pairGenIntChar = pairGen

sumGenIntFloat :: Gen (Sum Int Float)
sumGenIntFloat = sumGenEqual

sumGenFirstChar :: Gen (Sum Char Double)
sumGenFirstChar = sumGenFirsts
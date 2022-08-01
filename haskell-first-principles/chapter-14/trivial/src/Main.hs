module Main where

import Test.QuickCheck

data Trivial = Trivial deriving (Eq,Show)

instance Arbitrary Trivial where
  arbitrary = trivialGen

trivialGen :: Gen Trivial
trivialGen = return Trivial

main :: IO()
main = do
    sample trivialGen


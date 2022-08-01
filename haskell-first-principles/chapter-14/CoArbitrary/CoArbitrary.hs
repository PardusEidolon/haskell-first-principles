{-# LANGUAGE DeriveGeneric #-}
module CoArbitrary where

import Test.QuickCheck
import GHC.Generics

data Bool' = True' | False' deriving (Generic)

instance CoArbitrary Bool'
instance Arbitrary Bool'

trueGen :: Gen Int
trueGen = coarbitrary True' arbitrary

falseGen :: Gen Int
falseGen = coarbitrary False' arbitrary

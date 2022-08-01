module Tests where

import Test.QuickCheck
import Test.Hspec
import Hello
import qualified Main as D

main :: IO()
main = hspec $ do 
    describe "Tests" $ do 
        it "1 + 1 is 2 quickmafs" $ do 
            (1 + 1) `shouldBe` (2::Int)
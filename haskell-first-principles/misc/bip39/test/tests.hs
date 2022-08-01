module Main where

import qualified Data.Map as M
import Bip39
import Test.QuickCheck
import Test.Hspec
-- --------------------------------------
-- An example
foo :: Gen String
foo = elements $ words "I amd a we lsd drugs car window" 
bar :: String -> Bool
bar x = x /= "hi"
test::Property
test = forAll foo bar
test2::Property
test2 = forAll (arbitrary::Gen String) bar

main' :: IO ()
main' = hspec $ 
    do describe "Bip39 Tests" $ do 
        it "x should not be equal to hi, this is what a test looks like" $ do 
             test
-- --------------------------------------

-- note: need to add in words from text file. time to invoke side effects!
main :: IO ()
main = hspec $ 
    do describe "Bip39 Tests" $ do 
        it "run tests on bip39 coded functions" $ do 
                 wl <- allWords
                 let 
                     ws = elements (M.elems wl)
                     go x = ((bipToNum x wl) >>= (\a -> intToBip a wl)) == Just x
                 verboseCheck (withMaxSuccess 10000 (forAll ws go))


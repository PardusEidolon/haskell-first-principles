module Main where

import qualified Data.Map as M
import Morse
import Test.QuickCheck
import Test.Hspec

allowedChars :: [Char]
allowedChars = M.keys letterToMorse

allowedMorse :: [Morse]
allowedMorse = M.elems letterToMorse

charGen :: Gen Char
charGen = elements allowedChars

morseGen :: Gen Morse
morseGen = elements allowedMorse

prop_thereAndBackAgain :: Property
prop_thereAndBackAgain =
    forAll charGen
    (\c -> ((charToMorse c)
        >>= morseToChar) == Just c)

-- main :: IO()
-- main = return ()

main :: IO()
main = hspec $ 
    do describe "Morse Tests" $ do 
        it "run tests on morse coded functions" $ do 
            quickCheck prop_thereAndBackAgain
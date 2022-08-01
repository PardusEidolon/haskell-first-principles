{-# LANGUAGE BlockArguments #-}
module Tests where

import Test.QuickCheck
import Test.QuickCheck.Monadic
import Test.Hspec
import Data.List (elemIndices,(\\))
import qualified Hangman as H

-- =======================================
--          QuickStart Reference
-- =======================================

mains :: IO ()
mains = hspec $ do
    describe "A hspec test" $ do
        it "1 + 1 is 2" $ do
            (1 + 1) `shouldBe` 2
    describe "A simple quickCheck" $ do
        it "strings are strings" $ do
            property $ forAll stringGen prop_f
        it "random string equal strings" $ do
            property prop_f
-- quickstart hspec and quick check boilerplate
prop_f :: String -> Bool
prop_f x = x == x
-- properties must always end up a boolean
stringGen :: Gen String
stringGen = elements $ words "welcomes to the jungle we have fun and games a the thing with you are the zellot of general byzintine fault tolerance computer vader system"
-- generate random values based on a list

-- =======================================
--  Havent fulled grasped quickCheck yet
-- =======================================

-- instance Arbitrary H.Puzzle where
--     arbitrary = genPuzzle

-- prop_randomWords :: Property
-- prop_randomWords =
--   monadicIO $ do
--     a <- run H.randomWord'
--     b <- run H.randomWord'
--     assert (a /= b)

-- prop_freshPuzzle :: String -> Bool
-- prop_freshPuzzle w = length discovered == length word && null guessed
--     where
--         (H.Puzzle word discovered guessed) = H.freshPuzzle w

-- genPuzzle :: Gen H.Puzzle
-- genPuzzle = do
--     w <- arbitrary
--     return $ H.freshPuzzle $ getNonEmpty (w :: NonEmptyList Char)

-- genCorrectGuess :: H.Puzzle -> Gen Char
-- genCorrectGuess p@(H.Puzzle words _ guessed) = 
--     let chars = words \\ guessed
--     in if null chars
--         then error $ "No remaining correct guesses for this puzzle:" ++ show p
--     else elements chars

-- genIncorrectGuesses :: H.Puzzle -> Gen Char
-- genIncorrectGuesses p@(H.Puzzle words _ guessed) = do
--     c <- arbitrary
--     if c `elem` words && c `notElem` guessed
--         then return c
--         else genIncorrectGuesses p

-- genPuzzleAndCorrectGuess :: Gen (H.Puzzle, Char)
-- genPuzzleAndCorrectGuess = do
--   p <- arbitrary
--   c <- genCorrectGuess p
--   return (p, c)

-- genPuzzleAndIncorrectGuess :: Gen (H.Puzzle, Char)
-- genPuzzleAndIncorrectGuess = do
--     p <- arbitrary
--     c <- genIncorrectGuesses p
--     return (p,c)

-- prop_fillInCharacterCorrect :: (H.Puzzle, Char) -> Bool
-- prop_fillInCharacterCorrect (p, c) = all (== Just c) filled && c `elem` guessed
--   where
--     (H.Puzzle word before _) = p
--     (H.Puzzle _ after guessed) = H.fillInCharacter p c
--     filled = map (after !!) $ elemIndices c word

-- prop_fillInCharacterIncorrect :: (H.Puzzle, Char) -> Bool
-- prop_fillInCharacterIncorrect (p, c) = all (== Just c) filled && c `elem` guessed
--   where
--     (H.Puzzle word before _) = p
--     (H.Puzzle _ after guessed) = H.fillInCharacter p c
--     filled = map (after !!) $ elemIndices c word

-- =======================================
--  simple hspec Tests
-- ======================================= 

-- HOF variables
word :: String
word = "hello"
guess :: Char
guess = 'e'

main :: IO ()
main = hspec $ do
    describe "fillInCharacter Equality" $ do
        it "Testing puzzles are the same" $ do
            let 
                puzzle  = H.fillInCharacter (H.freshPuzzle word) 'e'
                puzzle' = H.Puzzle word [Nothing,Just 'e',Nothing,Nothing,Nothing] ['e']
            puzzle `shouldBe` puzzle'
        it "Testing if guesses are in word" $ do
            let 
                puzzle  = H.freshPuzzle word
                puzzle' = H.Puzzle word (map(const Nothing) word) []
            H.charInWord puzzle guess `shouldBe` H.charInWord puzzle' guess
        
        it "Testing for incorrect guesses" $ do
            let 
                puzzle  = H.fillInCharacter (H.freshPuzzle word) 'w'
                puzzle' = H.Puzzle word [Nothing,Nothing,Nothing,Nothing,Nothing] ['w']
            puzzle `shouldBe` puzzle'
    
    describe "handleGuess Equality" $ do
        it "character already guessed" $ do
            let 
                puzzle  = H.fillInCharacter (H.freshPuzzle word) guess
                puzzle' = H.Puzzle word [Nothing,Just guess,Nothing,Nothing,Nothing] [guess]
            
            result <- H.handleGuess puzzle guess
            result `shouldBe` puzzle'
        
        it "character is in word" $ do
            let 
                puzzle' = H.Puzzle word [Nothing,Just guess,Nothing,Nothing,Nothing] [guess]
                puzzle  = H.freshPuzzle word
            result <- H.handleGuess puzzle guess
            result `shouldBe` puzzle'
        it "character is not in word" $ do
            let 
                puzzle' = H.Puzzle word [Nothing,Nothing,Nothing,Nothing,Nothing] ['z']
                puzzle  = H.freshPuzzle word
            result <- H.handleGuess puzzle 'z'
            result `shouldBe` puzzle'
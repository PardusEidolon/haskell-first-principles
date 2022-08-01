module Hangman where

import Control.Monad (forever)
import Data.Char (toLower)
import Data.Maybe (isJust,fromMaybe,catMaybes)
import Data.List (intersperse,(\\))
import System.Exit (exitSuccess)
import System.Random (randomRIO)

data Puzzle = Puzzle String [Maybe Char] [Char] deriving Eq
--                   word    discovered  guessed

newtype WordList = WordList [String] deriving (Eq,Show)

instance Show Puzzle where
  show (Puzzle _ discovered guessed) = (intersperse ' ' $ 
                                        fmap renderPuzzleChar discovered)
                                        ++ " guessed so far: " ++ guessed
-- an instance of Show typeclass for the datatype Puzzle: when the invoked were ignoring the first argument and applying fmap and our helper function 'renderPuzzleChar'  with our list of [Maybe Char] if Just 'a' then "a" otherwise give us a string of "_"
-- append a pre-defined sentence with the argument to the type Puzzle guessed.
allWords :: IO WordList
allWords = do
  dict <- readFile "data/dict.txt"
  return $ WordList (lines dict)
-- take the text in dict.txt file and put it into the variable dict return the words into the data constructor WordList with a list of strings

minWordLength :: Int
minWordLength = 1
-- minimum ammout of chars in a string
maxWordLength :: Int
maxWordLength = 10
-- maximum ammount of chars in a string
gameWords :: IO WordList
gameWords = do
  (WordList aw) <- allWords
  return $ WordList (filter gameLength aw)
  where gameLength w =
          let l = length (w :: String)
          in    l >= minWordLength
             && l <  maxWordLength
-- binds the words in dict.txt into the variable aw and filters out the list of strings that are greater than and equal too 1 and less than 10


randomWord :: WordList -> IO String
randomWord (WordList wl) = do
  randomIndex <- randomRIO (0,((length wl) - 1))
  return $ wl !! randomIndex
-- chooses a random number from our filtered word list and spits out a random word based on the index

randomWord' :: IO String
randomWord' = gameWords >>= randomWord
-- binds gameWords with the type IO WordList and applies WordList throught the function randomWord to give us an output of IO String (our random word btw)

freshPuzzle :: String -> Puzzle
freshPuzzle w = Puzzle w (map (const Nothing) w) []
-- because we already have a Show instance inplace it prints our generated puzzle to the console. the (map(const Nothing) w) generates a list of nothings equal to the chars in out word
-- which in turn invokes our Show instance for this datatype
charInWord :: Puzzle -> Char -> Bool
charInWord (Puzzle word _ _) c = elem c word
-- checks our guess with the chosen word returns true if correct otherwose false

alreadyGuessed :: Puzzle -> Char -> Bool
alreadyGuessed (Puzzle _ _ guessed) c = elem c guessed
-- a helper function to tell us whether or not we have already guessed the letter

renderPuzzleChar :: Maybe Char -> Char
renderPuzzleChar c = fromMaybe '_' c
-- returns our char if Just Char else '_' when Nothing

fillInCharacter :: Puzzle -> Char -> Puzzle
fillInCharacter (Puzzle word filledInSoFar s) c = 
    Puzzle word newFilledInSoFar (c:s)
        where zipper guessed wordChar guessChar =
                if wordChar == guessed
                    then Just wordChar
                    else guessChar
              newFilledInSoFar =
                  zipWith (zipper c) word filledInSoFar
-- build out the 'Puzzle' constructor with our discovered words in maybe form and the guesed words

handleGuess :: Puzzle -> Char -> IO Puzzle
handleGuess puzzle guess = do
    putStrLn $ "Your guess was: " ++ [guess]
    case (charInWord puzzle guess
         , alreadyGuessed puzzle guess) of
     (_, True) -> do
        putStrLn "You already guessed that\
                \ character, pick \
                \ something else!"
        return puzzle
     (True, _) -> do
        putStrLn "This character was in the\
                \ word, filling in the word\
                \ accordingly"
        return (fillInCharacter puzzle guess)
     (False, _) -> do
        putStrLn "This character wasn't in\
                \ the word, try again."
        return (fillInCharacter puzzle guess)
-- the primary input for our guesses, depending on the case of our predicate it will return 3 possible outputs.

wrongGuesses :: Puzzle -> Int
wrongGuesses (Puzzle _ filledInSoFar guessed) = length $ guessed \\ catMaybes filledInSoFar
-- takes our guessed words and runs a list difference on the words that are already guessed to give us an Int we call this HOF into the function below

gameOver :: Puzzle -> IO ()
gameOver p@(Puzzle wordToGuess _ _) =
    if (wrongGuesses p > 7) then
        do putStrLn "You lose!"
           putStrLn $ "The word was: " ++ wordToGuess
           exitSuccess
        else return ()
-- game function for our gameover case. takes the helper function `wrongGuesses` and pattern matches on the wordToGuess as well as a as-pattern for our helper
-- function mentioned earlier. until the guesses we have exceed 7 then we invoke and exit call to close the program

gameWin :: Puzzle -> IO ()
gameWin (Puzzle _ filledInSoFar _) =
    if all isJust filledInSoFar then
        do putStrLn "You win!"
           exitSuccess
        else return ()
-- game function for when we win. invokes an exit of the program when all the list of words we have guessed are all `Just _` True.

runGame :: Puzzle -> IO ()
runGame puzzle = forever $ do
    gameOver puzzle
    gameWin puzzle
    putStrLn $ "Current puzzle is: " ++ show puzzle
    putStr "Guess a letter: "
    guess <- getLine
    case guess of
        [c] -> handleGuess puzzle c >>= runGame
        _   -> putStrLn "Your guess must be a single character"
-- `forever` calls our two game functions `gameWin` & `gameOver` until either one exits with an `exitSucess` call.
-- the lower half prints our random word into the console and prompts the user to guess a letter by binding the IO String into the variable guess 
-- in the case of our variable `guess` pass the puzzle and c arguments  into the function handle guess and bind it with our current function else print a string into the console. 
main :: IO ()
main = do
    word <- randomWord'
    let puzzle =
            freshPuzzle (fmap toLower word)
    runGame puzzle
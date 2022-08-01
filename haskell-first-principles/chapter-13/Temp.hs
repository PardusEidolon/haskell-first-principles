module HSandbox where
-- delete this file when your done :)
import Data.List
import Data.Maybe
import Data.Char
import Control.Applicative (WrappedArrow(WrapArrow))
-- #Types
data Puzzle = Puzzle String [Maybe Char] [Char]
newtype WordList = WordList [String] deriving (Eq,Show)
-- #==========
-- #type instances
instance Show Puzzle where
  show (Puzzle _ discovered guessed) = (intersperse ' ' $ fmap renderPuzzleChar discovered) ++ " guessed so far: " ++ guessed
-- #==========
-- # Functions Start Here

aWord :: IO WordList
aWord = do
    typeWords <- getLine
    return $ WordList (words typeWords)
fooBar :: IO WordList
fooBar = do
    (WordList aw) <- aWord
    return $ WordList aw

barFoo :: WordList -> IO String
barFoo (WordList wl) = do
    return $ wl !! wIndex
    where 
        wIndex = 1

freshPuzzle :: String -> Puzzle
freshPuzzle w = Puzzle w (map (const Nothing) w) []

renderPuzzleChar :: Maybe Char -> Char
renderPuzzleChar c = fromMaybe '_' c

fLength :: String -> Bool
fLength w =
    let wordlength = length w
    in             wordlength >= 5 && wordlength < 9

fillInCharacter :: Puzzle -> Char -> Puzzle
fillInCharacter (Puzzle word filledInSoFar s) c = 
    Puzzle word newFilledInSoFar (c:s)
        where zipper guessed wordChar guessChar =
                if wordChar == guessed
                    then Just wordChar
                    else guessChar
              newFilledInSoFar =
                  zipWith (zipper c) word filledInSoFar

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

charInWord :: Puzzle -> Char -> Bool
charInWord (Puzzle word _ _) c = elem c word
-- checks our guess with the chosen word returns true if correct otherwose false

alreadyGuessed :: Puzzle -> Char -> Bool
alreadyGuessed (Puzzle _ _ guessed) c = elem c guessed
-- a helper function to tell us whether or not we have already guessed the letter

wrongGuesses :: Puzzle -> Int
wrongGuesses (Puzzle _ filledInSoFar guessed) =
  length $ guessed \\ catMaybes filledInSoFar

runGame :: Puzzle -> IO ()
runGame puzzle = do
    putStrLn $ "Current puzzle is: " ++ show puzzle
    putStr "Guess a letter: "
    guess <- getLine
    case guess of
        [c] -> handleGuess puzzle c >>= runGame
        _   -> putStrLn "Your guess must be a single character"

foo :: String -> Maybe Char
foo guess = case guess of
    [c] -> Just c
    _   -> Nothing

bar :: [Maybe Char] -> String
bar [] = []
bar (x:xs) = case x of
    Just x -> x : bar xs
    Nothing -> '_' : bar xs
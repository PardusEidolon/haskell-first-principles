module Main where

import System.Exit (exitFailure,exitSuccess)
import Control.Monad (forever)
import System.Environment (getArgs)
import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)
import Bip39
-- import Text.Read

numToBip :: IO ()
numToBip = forever $ do
    nums <- fmap readMaybe getLine
    -- make a number readable safer cause were using readMaybe instead of read
    -- index of a list is always 0
    go nums
    where
        go n = case n of
            Just nmbr -> do
                wrds <- allWords
                case intToBip (nmbr - 1) wrds of
                    Just x  -> putStrLn x
                    Nothing -> putStrLn "Number doesnt exist in list!"
            Nothing -> putStrLn "Spaces, Words and Floating numbers are not allowed"


convertToInt :: IO ()
convertToInt = forever $ do
    wrds <- allWords
    myWrd <-  getLine
    go myWrd wrds
    where
        go w ws = if w == "q" then exitSuccess else 
            do 
                case bipToNum w ws of
                    Just r  -> putStrLn $ show (r + 1)
                    Nothing -> putStrLn $ "Word is not in the wordlist! Try again!"
-- converts word to number

main :: IO ()
main = do
    mode <- getArgs
    case mode of
        [arg] ->
            case arg of
            "from" -> do
                putStrLn "==================================================="
                putStrLn "          JACKS BIP39 WORD PROGRAM v0.1            "
                putStrLn "==================================================="
                putStrLn "Convert a word from the bip39 worldlist to a number"
                putStrLn "press ctrl + c to exit" 
                convertToInt
            "to"   -> do
                putStrLn "==================================================="
                putStrLn "          JACKS BIP39 WORD PROGRAM v0.1            "
                putStrLn "==================================================="
                putStrLn "Convert a number from the bip39 worldlist to a word"
                putStrLn "press ctrl + c to exit" 
                numToBip
            _      -> argError
        _ -> argError
    where argError = do
            putStrLn "Please specify the first argument as being 'from' or 'to' bip39, such as: bip39 to"
            exitFailure
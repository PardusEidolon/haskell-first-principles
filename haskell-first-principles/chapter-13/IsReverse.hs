module IsReverse where

import Control.Monad (forever)
import Data.Char
import System.Exit
import Data.Text (replace)
import Data.Maybe

palindrome :: IO ()
palindrome = forever $ do
    line1 <- getLine
    case (line1 == reverse line1) of
        True -> putStrLn "It's a palindrome!"
        False -> do
            putStrLn "Nope!"
            exitSuccess

palindrome2 :: IO ()
palindrome2 = forever $ do
    line1 <- getLine
    let line2 = map toLower . catMaybes . map spaces $ line1
    case (line2 == reverse line2) of
        True  -> putStrLn "Noice!"
        False -> do
            putStrLn "WhAt! This is impossible!"
            exitSuccess 


spaces :: Char -> Maybe Char
spaces s
    | s == ' '  = Nothing
    | s /= ' '  = Just s
    | otherwise = Nothing

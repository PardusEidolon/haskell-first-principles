module Main where

import qualified Hangman as H
import System.IO

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  H.main
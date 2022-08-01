module Main where

import Hello
import DogsRule
import System.IO

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  putStr "Your name here: "
  name <- getLine
  sayHello name
  dogs

module Main where

import qualified Cipher as C
import System.IO

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  C.main

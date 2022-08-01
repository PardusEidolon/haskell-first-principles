module LanguangeEX where

import Data.Char

-- Captilise a word
capitalizeWord :: String -> String
capitalizeWord [] = []
capitalizeWord (x:xs) = toUpper x : xs

-- Capitalise Paragraph
capitalizeParagraph :: String -> String
capitalizeParagraph = unwords . capitalize . words
   where
       capitalize [] = []
       capitalize wws@(w:ws) = capitalizeWord w : capitalizeAfterPeriod wws
       endsInPeriod [] = False
       endsInPeriod w = last w == '.'
       capitalizeAfterPeriod (wb:w:ws) =
           if endsInPeriod wb
               then capitalizeWord w : capitalizeAfterPeriod (w:ws)
               else w : capitalizeAfterPeriod (w:ws)
       capitalizeAfterPeriod _ = []


main :: IO()
main = do
    putStrLn $ capitalizeParagraph "Let's take this first paragraph for instance.\n"
    putStrLn $ capitalizeParagraph "to begin, we take a peroid . but not just any peroid, no,\n"
    putStrLn $ capitalizeParagraph "for you see this is a special peroid. a very special peroid\n"
    putStrLn $ capitalizeParagraph "the best of peroids, long live puncuation!"
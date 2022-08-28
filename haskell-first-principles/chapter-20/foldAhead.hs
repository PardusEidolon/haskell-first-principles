module FoldAhead where

import qualified Data.Foldable as F
import Data.List

-- like the function unwords but worse...
foo :: String -> [String] -> [String]
foo _ [] = []
foo str (x:xs) = (x : str : foo str xs)

wordy :: [String]
wordy = words "I liek strings"

foldMeh :: String
foldMeh = F.fold finalString
    where
        go = foo " " wordy
        finalString = take (length go - 1) go
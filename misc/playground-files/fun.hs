module Fun where

import Data.List

gapFill :: a -> [a] -> [a]
gapFill x y = intersperse x y

gapFunc :: (a -> [b] -> [c]) -> a -> [b] -> [c]
gapFunc f x y = f x y

gapConc :: (Char -> [Char] -> [Char]) -> Char -> [Char] -> IO()
gapConc f x y = putStrLn (f x y)
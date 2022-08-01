module FinalExercises where

-- 1.
-- Check markdown file for type methods in root directory.

-- 2.
-- write some instances check the applicprops folder

-- 3.
-- Combinations

import Control.Applicative(liftA3,liftA2)
import Data.List (permutations)

stops :: String
stops = "pbtdkg"

vowels :: String
vowels = "aeiou"

consonants :: String
consonants = "bcdfgh"

combos :: [a] -> [b] -> [c] -> [(a,b,c)]
combos xs ys zs = liftA3 (,,) xs ys zs

transform :: (Char,Char,Char) -> String
transform (x,y,z) = [x,y,z]

pf :: [String]
pf =   concat . fmap permutations . fmap transform . combos stops vowels $ consonants
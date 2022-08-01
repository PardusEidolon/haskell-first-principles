module Bip39 where

import Data.List.Index
import qualified Data.Map as M

type BipWords = String

maxNum :: Int
maxNum = 2048

minNum :: Int
minNum = 1

indexWords :: [BipWords] -> M.Map Int BipWords
indexWords x  = M.fromList $ indexed x
-- similar to the function below but indexes the a list of strings to the datatype fromList from the type Map

allWords :: IO (M.Map Int BipWords)
allWords = do
  wrds <- readFile "data/bip39_en.txt"
  return $ indexWords (lines wrds)

-- read the file bip39_en text file and index them into a list of tuples contiaining an Int and Bipwords wich is just a type alias for a string

intToBip :: Int -> M.Map Int BipWords -> Maybe BipWords
intToBip key list = M.lookup key  list
-- Look up a word depeding on the key input to the function in the list of allwords

testWords :: M.Map Int BipWords
testWords = M.fromList [(1,"aliens"),(2,"aeroplane"),(3,"chickenButt"),(4,"catButt")]
-- some words for testing functions

bipAndInt :: M.Map Int BipWords -> M.Map BipWords Int
bipAndInt x = M.foldrWithKey (flip M.insert) M.empty x
-- flips intgers and strings with strings and integers in the list [()] with the datatype fromList


bipToNum :: BipWords -> M.Map Int BipWords -> Maybe Int
bipToNum w x = M.lookup w (bipAndInt x)
-- Look up a number depeding on word as an input to the function in the list of allwords
module Index where

import Data.List
import Data.Maybe
import Data.Char
import qualified Data.Map as M

-- newtype WordsList = WordsList [String] deriving (Eq,Show)

type BipWords = String

-- myWords :: WordsList
myWords :: M.Map BipWords Int 
myWords = M.fromList [("abandon",0001),("ability",0002),("able",0003),("about",0004),("above",0005)]

wordToBip :: BipWords -> Maybe Int
wordToBip w = M.lookup w myWords

myWords2 :: [BipWords]
myWords2 = ["abandon","ability","able","about","above"]

-- words' :: [BipWords] -> Int
words' x 
    | elem x myWords2 = "yes"
    | otherwise = "no"

foo :: Num b => [a] -> b
foo [] = 0
foo (_:xs) = 1 + foo xs
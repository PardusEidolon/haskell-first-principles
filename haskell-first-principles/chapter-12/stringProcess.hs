module StringProcess where

import Data.Char
import Data.Maybe

notThe :: String -> Maybe String
notThe s
    | head . stringIsUpper $ s  = Nothing
    | s /= "the" = Just s
    | otherwise  = Nothing

replaceThe :: String -> String
replaceThe s = unwords . replace . words $ s
    where
        replace [] = []
        replace (x:xs) = 
            case notThe x of
                Just x  -> x : replace xs
                Nothing -> "a" : replace xs 

stringIsUpper :: String -> [Bool]
stringIsUpper s = map isUpper s

countTheBeforeVowel :: String -> Integer
countTheBeforeVowel = go . words
    where 
        go (wa:wb:ws) = 
            case notThe wa of
                Just _  -> go (wb:ws)
                Nothing -> 
                    if vowelInitial wb
                        then 1 + go (wb:ws)
                        else go (wb:ws)
        go _ = 0 

vowelInitial :: String -> Bool
vowelInitial [] = False
vowelInitial (x:_) = isVowel x

isVowel :: Char -> Bool
isVowel c = c `elem` vowels

countVowels :: [Char] -> Integer
countVowels = toInteger . length . filter isVowel

-- declaring string values
cowLove :: String
cowLove = "the cow loves us"

vowels :: String
vowels = "aeiou"


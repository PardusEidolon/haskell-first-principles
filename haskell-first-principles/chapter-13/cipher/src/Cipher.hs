module Cipher where

import Data.Char
import Control.Monad
import System.Exit
import Data.Maybe

-- VigenèreCipher

encryptPF :: String -> String -> String
encryptPF = zipWith shift . cycle . map let2int

-- we take 2 strings one being our key and the other being our secret message. In the beggining our key is reduced down to a list of integers, because our string is 
-- being mapped into the function let2int wich takes a letter and returns an integer. we then cycle that function, esstionally meaning that our key wich is now a list of integers is being
-- cycled over itself repeatibly. i.e; [1,2,3] is [1,2,3,1,2,3,1,2,3....to infinity and beyond]. with our recursively cycled list of integers we take that list and our message and take the elements of the key
-- and our message into the fucntion shift which takes a integer and a char and returns a char that has its position shifted based on the index of the english alphabet, i.e 26 chars.
-- our function continues to do this until all our elements in our list hahve been exhausted and thus we end up with list of ciphered gibberish.

-- map 
shiftFactor :: String -> [Int]
shiftFactor = map let2int

-- shift a Char to a different char depending on the Int execute expression if Char is capitalised else return input Char
shift :: Int -> Char -> Char
shift n c
          | isUpper c = int2let ((let2int c + n) `mod` 26)
          | otherwise = c

-- convert Char to Int
let2int :: Char -> Int
let2int c = ord c - ord 'a'
-- convert Int to Char
int2let :: Int -> Char
int2let n = chr (ord 'a' + n)

main :: IO ()
main = forever $ do
    putStr "key: "
    key <- getLine
    putStr "message: "
    message <- getLine
    putStrLn (">> " ++ (encryptPF (map toUpper key) (map toUpper message)))
    exitSuccess


-- handleCaps :: String -> Bool
-- handleCaps x = foldr ((\a b -> a && b) . isUpper) True x

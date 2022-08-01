module ValidateWord where

-- defining modules
import Data.Char ()
import Data.List ()
import Data.Maybe ()

-- defining new types
newtype Word' = Word' String deriving (Eq,Show)

-- declaring consonant and vowel String values
consonants :: String
consonants = "bcdefgjklmnpqstvxzhrwy"
vowels :: String
vowels = "aeiou"

-- functions start here
mkWord :: String -> Maybe Word'
mkWord s = if countVowel > countCon then Nothing else Just $ Word' s
    where 
        countVowel = length . filter isVowel $ s
        countCon   = length . filter isConsonant $ s

-- helper functions
isVowel :: Char -> Bool
isVowel c = c `elem` vowels
isConsonant :: Char -> Bool
isConsonant c = c `elem` consonants
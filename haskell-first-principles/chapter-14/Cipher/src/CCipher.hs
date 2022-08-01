module CCipher where
import Data.Char ( ord, chr )

caesarChar :: Int -> Char -> Char
caesarChar num char = chr (ord 'a' + shift)
   where distance = ord char - ord 'a'
         shift = (distance + num) `mod` 26

caesar :: Int -> String -> String
caesar _ [] = []
caesar 0 str  = str
caesar num str = map (caesarChar num) str

unCaesar :: Int -> String -> String
unCaesar num str = map (caesarChar (26 - (mod num 26))) str
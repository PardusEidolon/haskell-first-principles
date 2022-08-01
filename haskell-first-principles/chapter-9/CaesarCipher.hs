module CaesarCipher where

import Data.Char

caesarChar :: Int -> Char -> Char
caesarChar num char = chr (ord 'a' + shift)
   where distance = ord char - ord 'a'
         shift = (distance + num) `mod` 26

caesar :: Int -> String -> String
caesar num str = map (caesarChar num) str

unCaesar :: Int -> String -> String
unCaesar num str = map (caesarChar (26 - (mod num 26))) str
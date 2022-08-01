module Curry where

addOne :: String -> IO ()
addOne x = putStrLn greeting
              where greeting = x ++ "?!?!"

position:: String -> Char
position x = (!!) x 3

dropping :: Int -> String -> String
dropping y x = drop y x

dingdong :: String
dingdong = "ding dong"

thirdLetter :: String -> Char
thirdLetter x = (!!) x 3

letterIndex :: Int -> Char
letterIndex x = (!!) "curry is awesome" x

rvrs :: String -> IO ()
rvrs x = putStrLn myWord
           where myWord = reverse x

addition :: Int -> Int
addition x = x + 3

polka x = addition x 
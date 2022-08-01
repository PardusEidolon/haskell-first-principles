module Curry where

curryString :: [Char]
curryString = "curry is awesome" ++ "!"

curryIndex :: Int -> Char
curryIndex x = (!!) curryString x

curryDrop :: Int -> String
curryDrop x = drop x curryString

thirdString :: Char
thirdString = (!!) curryF a
        where 
            a = 3

curryF :: [Char]
curryF = "Curry is awesome"

rvrs :: String -> String
rvrs x = concat [awesome," ",curryis," ",curry ]
    where
        awesome = drop 9 x
        curryis = take 2 $ drop 6 x
        curry = take 5 x

main :: IO()
main = print $ rvrs "curry is awesome"





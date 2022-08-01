module Reverse where

rvrs :: String -> String
rvrs x = reverse x

main :: IO ()
main = putStrLn $ rvrs "beatslow"
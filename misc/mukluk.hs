module Mukluk where

data Luk = Luk {name :: String,
                age :: Int,
                weight :: Double} deriving Show

mukluk :: String -> IO () 
mukluk a = 
    if jack
        then putStrLn "Yes"
    else
       putStrLn "No"
    where jack = a == "can jack put on the mukluks?"

thanks :: IO () 
thanks = putStrLn "your welcome :)"
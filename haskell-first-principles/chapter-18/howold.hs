module HowOld where

import Control.Monad

sayHi :: String -> IO String
sayHi s = do
    putStrLn s
    getLine

readM :: Read a => String -> IO a
readM = return . read

getAge :: String -> IO Int
getAge = sayHi >=> readM

askForAge :: IO Int
askForAge = getAge "How old are you?"
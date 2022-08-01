module StackedFuncts where

import Data.Maybe
import Text.Read
import Control.Monad (forever)
import System.Exit (exitFailure,exitSuccess)

n :: Maybe String
n = Nothing 
w :: Maybe String
w = Just "woohoo" 
ave :: Maybe String
ave = Just "Ave" 
lms :: [Maybe String]
lms = [ave, n, w]

replaceP ::  a -> Char
replaceP a = const 'p' a

foobar :: (a -> b) -> [Maybe a] -> [Maybe b]
foobar f a = (fmap . fmap) f a

thrice :: (a -> b) -> [Maybe [a]] -> [Maybe [b]]
thrice = fmap . fmap . fmap

---

fmapn :: IO ()
fmapn = forever $ do
    n <- fmap readMaybe getLine
    go n
    where 
        go :: Maybe Integer -> IO ()
        go n = case n of
            Just n -> print $ Just n
            Nothing -> exitSuccess
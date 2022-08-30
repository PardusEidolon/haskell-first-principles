{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.ByteString.Lazy as B hiding (map)
import Network.Wreq

main :: IO ()
main = putStrLn "dev"

urls :: [String]
urls = [
         "http://httpbin.org/ip"
       , "http://httpbin.org/bytes/5"
       ]


mappingGet :: [IO (Response B.ByteString)]
mappingGet = map get urls 
-- the wrong dum dum way

-- traverse :: (Traversable t, Applicative f) => (a -> f b) -> t a -> f (t b)

traversedUrl :: IO [Response B.ByteString]
traversedUrl = traverse get urls
-- the right way


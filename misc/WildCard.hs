{-# LANGUAGE RecordWildCards #-}

module WildCard where

data Wild = Wild {
            name :: String
          , age :: Int
          , weight :: Double
          } deriving Show

record :: String -> Int -> Double -> Wild
record name age weight = Wild {..}

-- What RecordWildCards does is that it gives us the ability to access records without having to verbosely type them out. 

-- By typing the name of the constructor we only need to add a curly bracket and a couple dots and thats enough 
-- to tell the compiler that were accessing the record field for which we can then pattern match.
-- its no different that what we just did with foo' but shorter.

foo :: Wild -> IO ()
foo Wild {..} = do
        putStrLn (show age)
        putStrLn name
        putStrLn (show weight)
 
--  Explicitly typing out our record type for paternmatching
 
foo' :: Wild -> IO ()
foo' (Wild n a w) = do
    putStrLn n
    putStrLn $ show a
    putStrLn $ show w

 
bar :: Wild
bar = record "Jack" 2 2.2
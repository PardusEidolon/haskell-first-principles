module Database where

import Data.Time

data DatabaseItem = DbString String 
                    | DbNumber Integer 
                    | DbDate UTCTime 
                    deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase = [ DbDate (UTCTime (fromGregorian 1911 5 1) (secondsToDiffTime 3423)), 
                DbNumber 9001, DbNumber 1000, 
                DbString "Hello there", DbString "Hola, senor Kenobi",
                DbDate (UTCTime (fromGregorian 1921 5 1) (secondsToDiffTime 34123))]

filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate ls = [ utc | DbDate utc <- ls]

filterDbNum :: [DatabaseItem] -> [Integer]
filterDbNum ls = [ x | DbNumber x <- ls]

mostRecent :: [DatabaseItem] -> UTCTime
mostRecent ls = foldr max (head times) times
            where times = filterDbDate ls

sumAllDb :: [DatabaseItem] -> Integer
sumAllDb ls = sum $ filterDbNum ls

sumAllDb' :: [DatabaseItem] -> Integer
sumAllDb' ls = foldr (+) 0 (filterDbNum ls)

avgDb :: [DatabaseItem] -> Float
avgDb ls = (fromIntegral . sum $ num) / (fromIntegral . length $ num)
        where num = filterDbNum ls
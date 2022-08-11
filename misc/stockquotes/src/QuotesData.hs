{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module QuotesData where

import Data.Time (Day, parseTimeM, defaultTimeLocale,fromGregorian)
import Data.ByteString.Char8 (unpack)
import GHC.Generics (Generic)
import Data.Csv (FromNamedRecord, FromField (..))

import Data.Maybe

-- * Quote Data Documentation
-- | A data type to interperate the CSV fields.
-- The following fields:
-- 
--  [@Day@]: Were taking the type @Day@ from the 'Time' package in the format YYYY-MM-DD
--  [@Volume@]: Because volume is a whole number we will have to generalise this later when generating the reports
--  [@..@] As for the rest of the remainning fields, we are only dealing with floating point numbers.
-- 
-- Because weve imported cassava @QuotesData@ needs to have a FromNamedRecord instance to convert the CSV records from user defined data types.
data QuoteData = QuoteData {
    day :: Day ,
    volume :: Int ,
    open :: Double ,
    close :: Double ,
    high :: Double , 
    low :: Double 
    } deriving (Generic, FromNamedRecord, Show)

-- | Defines how to convert the day field into a value we care about. Because the type doesnt have an instance we need to define on ourselves.
-- 
--  we can flip the dates around if we want a differnt format:
-- 
-- >>> parseField = parseTimeM True defaultTimeLocale "%m-%d-%Y" . unpack

instance FromField Day where
    parseField = parseTimeM True defaultTimeLocale "%Y-%m-%d" . unpack --regular normal date format YYYY-MM-DD


data QField = Open | Close | High | Low | Volume deriving (Eq,Show,Enum,Ord,Bounded)

-- | Unwrap the QuoteData type for our number fields in the CSV, Take note that when parsing the @Volume@ field it's converted to a type of a double because of the integral converstion
-- we get a type of:
-- 
-- >>> field2fun Volume = fromIntegral . volume :: Double
-- 
-- fromIntegral is taking our Integer and generalising it to be an ad hoc polymophic type constrained by the @Num@ class and because of our defined output for the function
-- The compiler is able to interpret and spit out a @Double@

field2fun :: QField -> QuoteData -> Double
field2fun Open = open
field2fun Close = close
field2fun High = high
field2fun Low = low
field2fun Volume = fromIntegral . volume

-- | Example Quote data Value

exampleQuote :: QuoteData
exampleQuote = QuoteData (fromGregorian 2022 07 25) (120234) (12.83) (13.48) (13.49) (12.82)


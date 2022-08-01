{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module QuotesData where

import Data.Time (Day, parseTimeM, defaultTimeLocale,fromGregorian)
import Data.ByteString.Char8 (unpack)
import GHC.Generics (Generic)
import Data.Csv (FromNamedRecord, FromField (..))

import Data.Maybe

data QuoteData = QuoteData {
    day :: Day ,
    volume :: Int ,
    open :: Double ,
    close :: Double ,
    high :: Double , 
    low :: Double 
    } deriving (Generic, FromNamedRecord, Show)

instance FromField Day where
    parseField = parseTimeM True defaultTimeLocale "%Y-%m-%d" . unpack --regular normal date format YYYY-MM-DD
    -- parseField = parseTimeM True defaultTimeLocale "%m-%d-%Y" . unpack -- American flipped date format MM-DD-YYYY

data QField = Open | Close | High | Low | Volume deriving (Eq,Show,Enum,Ord,Bounded)

field2fun :: QField -> QuoteData -> Double
field2fun Open = open
field2fun Close = close
field2fun High = high
field2fun Low = low
field2fun Volume = fromIntegral . volume

-- Example Values

exampleQuote :: QuoteData
exampleQuote = QuoteData (fromGregorian 2022 07 25) (120234) (12.83) (13.48) (13.49) (12.82)


module Params where

import Options.Applicative
import Data.Text (Text, strip)

-- * Documentation
-- | A Definition list for our type below
-- 
--      [@fname@]: Our file path the type here is an alias for string
-- 
--      [@company@]: company name to show on the report
-- 
--      [@chart@]: Wheather or not we generate our candle stick and bar charts
-- 
--      [@htmlfile@]: Our file path to generate an html file should we choose to do so
-- 
--      [@silent@]: If True we don't generate the stat report. 
data Params = Params { fname :: FilePath
                     , company :: Maybe Text
                     , chart :: Bool
                     , htmlFile :: Maybe FilePath
                     , silent :: Bool
                     } deriving Show

-- ** Functions
-- | Our constructor for the datatype @__Parser__@ we use this function to apply the functions to construct values for our @__Params__@ datatype.
-- 
-- We have the following functions which define what value gets applied to the constructor of the type:
-- 
--      [@strArgument@]: A builder for out string argument we use this for our filpath.
-- 
--      [@optional@]: Provides structure for the @company@ field which is also using Text
-- 
--      [@switch@]: A builder for a @Boolean@ field for @Parser@
-- 
-- Beccause where using applicative here, were partially applying to the data contructor Params using fmap to preserve the structure...
-- to eventually then give us an output of Parser Params
-- 
-- We are preserving Parser by lifting it, taking out type Params and partially applying until we fill out all the fields.
-- after weve fully applied our type we then lift Parser back down and get Parser Params
mkParams :: Parser Params
mkParams = 
    Params <$> strArgument
                    (metavar "FILE" <> help "CSV file name")
                <*> optional (strip <$> strOption 
                        (long "name" <> short 'n' <> help "Company name"))
                <*> switch
                        (long "Chart" <> short 'c' <> help "Generate chart")
                <*> optional (strOption $
                        long "html" <> metavar "FILE" <> help "Generate Html report")
                <*> switch
                        (long "silent" <> short 's' <> help "Don't print statistics")

-- | Takes our Params type and executes. It also creates information for our Params by taking The helper combinator which takes any parser, and adds a help option to it.
cmdLineParser :: IO Params
cmdLineParser = execParser opts
    where
        opts = info (helper <*> mkParams) (fullDesc
                                         <> header "Stock Quotes CSV parser"
                                         <> footer "This program was created by jack@yumi.ai" 
                                         <> progDesc "Stock quotes data proccessing for generating html reports and charts from CSV files."
                                          )
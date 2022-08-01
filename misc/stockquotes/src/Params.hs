-- module Params (Params (..), cmdLineParser) where
module Params where

import Options.Applicative
import Data.Text (Text, strip)

data Params = Params { fname :: FilePath
                     , company :: Maybe Text
                     , chart :: Bool
                     , htmlFile :: Maybe FilePath
                     , silent :: Bool
                     } deriving Show

-- depending on how we want out CLI to work we fist need to describe our options for the parser


mkParams :: Parser Params
mkParams = 
    Params <$> strArgument
                    (metavar "FILE" <> help "CSV file name") -- a builder for a string argument
                    -- applies ^ to our fname field
                <*> optional (strip <$> strOption 
                        (long "name" <> short 'n' <> help "Company name")) -- optional is a useful modelling tool to allow things to fail
                        -- applies ^ to our company field
                <*> switch
                        (long "Chart" <> short 'c' <> help "Generate chart")
                        -- applies ^ to our chart field
                <*> optional (strOption $
                        long "html" <> metavar "FILE" <> help "Generate Html report")
                        -- applies to our htmlFile field
                <*> switch
                        (long "silent" <> short 's' <> help "Don't print statistics")
                        -- applies to our silent filed thus ending out application and leaving us with the type Parser Params

-- Beccause where using applicative here, were partially applying to the data contructor Params using fmap to preserve the structure...
-- to eventually then give us an output of Parser Params

-- We are preserving Parser by lifting it, taking out type Params and partially applying until we fill out all the fields.
-- after weve fully applied our type we then lift Parser back down and get Parser Params

cmdLineParser :: IO Params
cmdLineParser = execParser opts
    where
        opts = info (helper <*> mkParams) (fullDesc
                                         <> header "Stock Quotes CSV parser"
                                         <> footer "This program was created by jack@yumi.ai" 
                                         <> progDesc "Stock quotes data proccessing for generating html reports and charts from CSV files."
                                          )
-- Takes our Params type and executes, with a little bit of help form our friends 'info' which are just details and header smooshed at the end of the day to produce InfoMod Params
-- the library takes care of most of it so you dont have to.

-- (helper <*> mkParams) :: Parser (Params -> Params) -> Parser Params -> ParserInfo Params 
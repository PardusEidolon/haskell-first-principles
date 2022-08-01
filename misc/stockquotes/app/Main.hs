
{-# LANGUAGE RecordWildCards #-} -- let the compiler fill in the record for you instead of writing it out all the time for your functions
{-# LANGUAGE OverloadedStrings #-} -- every string is now generalised
module Main where

import Control.Monad (when, unless)
import qualified Data.ByteString.Lazy as BL (readFile, writeFile)
import Data.Csv (decodeByName)
import Data.Foldable (toList)
import Data.Text (unpack)

import Charts
import HtmlReport
import Params
import QuotesData
import StatReport

main :: IO ()
main = cmdLineParser >>= work -- bind params and parse through the function work
 
work :: Params -> IO ()
work params = do
    csvData <- BL.readFile (fname params) -- unwrap our file name and read our csv file
    case decodeByName csvData of -- decode quotes which has a derived instance for FromNamedRecord no thanks to our language extentions I think
    -- Vector is a class that is imported via the Vector package, which implements Int indexed arrays. so in the case it decodes correctly we get a type of Vector QuoteData
    -- Vector also implements both Functor and Traversable which both fold and at the same time presrve out QuoteData Structure thus leaving it intact, Huzzah!
      Left err -> putStrLn err -- if decoding fails such as putting in the wrong file path it screams an error
      Right (_,quotes) -> generateReports params quotes -- parse our decoded quotes which has the type of (Vector QuoteData) and our params into the function generate reports
      -- as mentioned be for we can use our that we pattern matched in the function generator reports because it has instances of Functor and Foldable, Huzzah!


generateReports :: (Functor t, Foldable t) => Params -> t QuoteData -> IO ()
generateReports Params {..} quotes = do
    unless silent $ putStr textRpt -- if False putStrLn otherwise when True do nothing
    -- silent being a field from our type Params (see :info Params for details in the REPl). 
    -- Because we have the GHC extention RecordWildCards enabled we can pattern match on this.
    when chart $ plotChart title quotes chartFname -- when chart is true plot the chart otherise when false don't plot the chart
    -- The field Char is from our record type Params which has the type is a Bool
    saveHtml htmlFile htmlRpt -- save our file to disk
    -- 
  where
    statInfo' = statInfo quotes
    textRpt = textReport statInfo' -- short hand value for out textReport function which returns a String
    htmlRpt = htmlReport title quotes statInfo' [chartFname | chart] -- if chart is True then print the filename into the list otherwise return an empty list
    -- htmlRpt takes our title our quotes and procceses that all into the html type 
    
    withCompany prefix = maybe mempty (prefix <> ) company -- name of the a company that outputs (Maybe Text), so we need to unpack into a String this when were done with this
    chartFname = unpack $ "chart" <> withCompany "_" <> ".svg" -- combine our company name with the file name for our chart, unpack it into a string
    title = unpack $ "Historical Quotes" <> withCompany " for " -- combine text then unpack and turn it into a string

    saveHtml Nothing _ = return () -- return empty for our output if our params contructor returns nothing
    saveHtml (Just f) html = BL.writeFile f html -- if our filepath comes back with (Just f) then use f to write our file


-- Similar function to our work function except this only spits out an IO List of our QuoteData to the REPl
readQuotes :: FilePath -> IO [QuoteData]
readQuotes fpath = do
  csvData <- BL.readFile fpath -- same as work but we take the path via user input
  case decodeByName csvData of -- identical to out work function
    Left err -> error err
    Right (_, quotes) -> return (toList quotes) -- as a result of decoding remember that the right value gives us a type of (Head,Vector QuotesData)
    -- Vector in this context is out (Foldable t) when parsing it through toList, toList requires that the t be an instance of foldable by the way.
    -- perfect, becuase its a generalised function we can just put it into a list and keep the structure and return back to IO! Huzzah!
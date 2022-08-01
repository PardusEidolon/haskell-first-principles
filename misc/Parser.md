# Parser Types

```Haskell
:t Params 
(m a) -> b -> (m f) -> b -> Params

Params <$> strArgument (metavar "FILE" <> help "CSV file name")
:t Functor f => f (Maybe Text -> Bool -> Maybe FilePath -> Bool -> Params)

-- lifting Parser and start partially applying
-- We are preserving Parser by lifting it, taking out type Params and partially applying until we fill out all the fields.
-- after weve fully applied our type we then lift Parser back down and get Parser Params
```
module Hello where

sayHi :: IO ()
sayHi = do
    putStr "Your name: "
    str <- getLine
    putStrLn $ ("Hello," ++ str ++ "!")


grabWords :: IO [String]
grabWords = do
    wrds <- readFile "./CHANGELOG.MD"
    return $ (lines wrds)

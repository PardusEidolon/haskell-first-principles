module NotaBurrito where


main :: IO (String)
main = do
    x1 <- getLine 
    x2 <- getLine 
    return (x1 ++ x2)


twoo :: IO ()
twoo = do 
    c <-  getLine
    c' <- getLine
    if c == c'
        then putStrLn "True"
    else return ()

okBoomer :: String -> IO ()
okBoomer name = putStrLn (name ++ " is a boomer")
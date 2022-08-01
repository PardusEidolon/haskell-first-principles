module Print3broken where

printSecond :: IO ()
printSecond = do
    putStrLn greeting
    --- to fix put this here: where greeting = "yaaaaarg"

main :: IO ()
main = do 
    putStrLn greeting
    printSecond
    where greeting = "yardnaaar"
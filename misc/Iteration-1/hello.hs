--hello.hs

module Hello where

sayHello :: String -> IO() 
sayHello x = 
    putStrLn ("Hello, " ++ x ++ "!")
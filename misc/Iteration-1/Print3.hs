module Print3 where

myGreeting :: String
myGreeting = "hello " ++ "there!"

hello :: String
hello = "hello"

world :: String
world = "world"

main :: IO ()
main = do 
    putStrLn myGreeting
    putStrLn secondGreeting
    where secondGreeting = concat [hello, " " , world]

-- (++) is the infix operator of the prefix function concat, kinda.


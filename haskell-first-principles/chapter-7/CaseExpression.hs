module CaseExpressions where

funcZ :: (Num a,Eq a) => a -> String
funcZ x = case x + 1 == 1 of
    True -> "cool beans"
    False -> "hang on..wut?"

funcF :: Eq a => [a] -> [Char]
funcF xs = case xs == reverse xs of
    True -> "yolo"
    False -> "Nolo?"

greetIfCool :: String -> IO()
greetIfCool coolness = case cool of
    True -> putStrLn "Welcome Brother"
    False -> putStrLn "get the fuk outta heere!"
    where cool = coolness == "password"
module TwiceIfEven where

doubleUp :: [Integer] -> [Integer]
doubleUp xs = do
    x <- xs
    if even x
        then [x*x,x*x]
        else []
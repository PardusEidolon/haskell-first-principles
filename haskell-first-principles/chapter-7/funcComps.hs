module FunctionComposites where

f x = take 5 . enumFrom $ x
    where x = 10

filtering :: Integral a => Int -> a -> [a]
filtering x y = take x . filter even . enumFrom $ y
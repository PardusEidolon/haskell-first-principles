module Chp7FuncExercises where

tensDigit :: Integral a => a -> a
tensDigit x = d
    where xLast = x `div` 10
          d = xLast `mod` 10

-- This does not have the same type as the originalversion
tensDigit' :: Integral a => a -> (a,a)
tensDigit' x = divMod x 10

-- Make a version that does 100 digi's instead
hunD :: Integral a => a -> a
hunD x = d2
    where d  = x `div` 100
          d2 = d `mod` 100

hunDy :: Integral a => a -> a
hunDy x = mod y 100
    where y = div x 100

hunDo :: Integral a => a -> a
hunDo x = d2
    where
        (d,_)  = x `divMod` 100
        (_,d2) = d `divMod` 10

-- implement a guard and a case version of a this function

foldBool :: a -> a -> Bool -> a
foldBool x y bool = 
    case bool of
        True -> x
        False -> y

foldBool2 :: (Num a, Show a )=> a -> a -> Bool -> IO()
foldBool2 x y bool
    | bool = print x
    | otherwise = print y

foldBool3 :: a -> a -> Bool -> a
foldBool3 x _ True = x
foldBool3 _ y False  = y

-- fill in the defition for question 3 of "let's write code"

g :: (f->a) -> (f,b) -> (a,b)
g f (a,b) = (f a,b)

-- Still cant figure out what arguments to apply to get a result for this function -_-
-- not matter i figured it out with arithmatic!
-- Arith 4

roundTrip :: (Show a, Read b) => a -> b
roundTrip a = read (show a)

main = do
    print ((roundTrip 45) :: Int)
    print (roundTripP 100)

roundTripP :: (Show a, Read a) => a -> a
roundTripP = read . show
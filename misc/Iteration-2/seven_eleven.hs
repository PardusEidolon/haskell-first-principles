module SevenEleven where

-- 7.11 Multichoice Questions
    -- 1. = d)
    -- 2. = b) 
    -- 3. = d)
    -- 4. = b)
    -- 5. = a)

-- okey, lets write some code.

tensDigitOG :: Integral a => a -> a
tensDigitOG x = d
    where xLast = x `div` 10
          d     = xLast `mod` 10

tensDigit :: Integral a => a -> (a,a)
tensDigit x = xLast
    where xLast = x `divMod` 10

-- no, this is not the same type and tensDigitOG Function.

hunD :: Integral a => a -> a
hunD x = d2
    where
        (d,_)  = x `divMod` 100
        (_,d2) = d `divMod` 10

foldy :: a -> a -> Bool -> a
foldy x y bool = case bool of
    True  -> x
    False -> y

gaurdFolds :: a -> a -> Bool -> a
gaurdFolds x y bool 
    | bool      = x
    | otherwise = y

g :: (a -> b) -> (a,c) -> (b,c)
g f (x,y) = (f x,y)

-- Arithmatec 4

roundTrip :: (Show a, Read b) => a -> b
roundTrip a = read $ show a

main = do
        print ((roundTrip 4) :: Int)
        print (id 4)

pointTrip :: (Show a, Read a) => a -> a
pointTrip a = read . show $ a

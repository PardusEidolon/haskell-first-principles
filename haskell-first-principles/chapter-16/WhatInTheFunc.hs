module WhatInTheFunc where

data WhoCares a = ItDoesnt | Matter a | WhatThisIsCalled deriving (Eq,Show)

instance Functor WhoCares where
    fmap _ ItDoesnt = ItDoesnt
    fmap _ WhatThisIsCalled = WhatThisIsCalled
    fmap f (Matter a) = Matter (f a)

bar :: Integer -> Integer -> Integer
bar _ 0 = 0
bar x n = x + bar x (n-1)

sumAll :: (Eq a, Num a) => a -> a
sumAll 0 = 0
sumAll n = n + sumAll (n-1)

-- repec the law of coMpOSeeTIon
-- respec the law of structure preservation
same :: [Integer] -> Bool
same ls = (fmap ((+2) . (+1)) $ ls) == (fmap (+2) . fmap (+1) $ ls)


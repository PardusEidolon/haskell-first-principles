module Recursion where

dividedBy :: Integral a => a -> a -> (a,a)
dividedBy num denom = go num denom 0
  where go n   d count
         | n < d = (count,n)
         | otherwise =
             go (n - d) d (count + 1)

-- function breakdown of the function dividedBy 10 2 = go 10 2 0
    -- (10 - 2) = 8 (count 1) = (1,8)
    -- (8  - 2) = 6 (count 2) = (2,6)
    -- (6  - 2) = 4 (count 3) = (3,4)
    -- (4  - 2) = 2 (count 4) = (4,2)
    -- (2  - 2) = 0 (count 5) = (5,0)

-- now write a function that recursivley sums the number from 1 to n

sumAll :: (Eq a, Num a) => a -> a
sumAll 0 = 0
sumAll n = n + sumAll (n-1)

-- time to break it down
    -- sumAll 5 = 5 + sumAll 4 = 5
    --   ⬇-------------⬆
    -- sumAll 4 = 4 + sumAll 3 = 4
    --   ⬇-------------⬆
    -- sumAll 3 = 3 + sumAll 2 = 3
    --   ⬇-------------⬆
    -- sumAll 2 = 2 + sumAll 1 = 2
    --   ⬇-------------⬆
    -- sumAll 1 = 1 + sumAll 0 = 1
-- sumAll needs to reach 0 in order to reach a result otherwise it will just be bottom 😎

multiAll :: Integral a => a -> a -> a
multiAll x 0 = x
multiAll x y = x + multiAll x (y-1)

-- let break it down on the dance floor yo!
    -- multiAll 10 2 = 10 + multiAll 10 1
    -- multiAll 20 1 = 10 + multiAll 20 1
    -- multiAll 30 0 = 10 + multiAll 30 0
    -- multiaLl 30 0 = 30

-- data DividedResult = Result Integer | DividedByZero deriving Show

m91 :: Integral a => a -> a
m91 n
    | n > 100 = n - 10
    | n < 100 = m91 (m91(n + 11))
    | otherwise = 91

-- let's try pull this apart shall we?
    -- m91 110 = is 110 greater than 100?...yes...then 110 - 10 = 100; condition is met
    
    -- m91 95 = is 95 greater than 100?...no...then 95 + 11 = 106; is 106 greater than 100; yes...
    -- then 106 - 10 = 96; m91 96 = is 96 greater than 100?...no then 96 + 11 = 107...is 107
    -- greater than 100? yes then 107 - 10 = 97..is 97 greater then 100 no then 97 + 11 = 108
    -- is 108 greater then 100 yes then 98 - 10 = 98..is 98 greater then 100 no then 98 + 11 = 109
    -- is 109 greater than 100? yes then 109 -10 - 99... is 99 greater then 100? no...then 99 + 11 = 110
    -- is 110 greater then 100? yes...then 110 - 10 = 100.. is 100 greater than 100? I dunno...ok then...91
    -- --------------------------------------------------------------------------------------------------
    -- Because we reached 100 the function will just return 91 the 'otherwise' is our fail safe, the exhaustive pattern if you will.
    -- the function doesnt know what to do when 100 == 100 so if it reaches this consensus then paste 91
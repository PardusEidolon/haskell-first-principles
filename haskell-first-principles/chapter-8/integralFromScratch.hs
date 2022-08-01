module IntegralFromScratch where

type Numerator   = Integer
type Denominator = Integer
type Quotient    = Integer


dividedBy :: Numerator -> Denominator -> Quotient
dividedBy = div

-- let's give it a little breakdown baby -_-

divBy2 :: Integral a => a -> a -> (a,a)
divBy2 num denom = go num denom 0
  where go n   d count
         | n < d = (count,n)
         | otherwise =
             go (n - d) d (count + 1)

-- function breakdown of the function divBy2    10 2 = go 10 2 0
    -- (10 - 2) = 8 (count 1) = (2,8)
    -- (8  - 2) = 6 (count 2) = (2,6)
    -- (6  - 2) = 4 (count 3) = (2,4)
    -- (4  - 2) = 2 (count 4) = (2,2)
    -- (2  - 2) = 0 (count 5) = (2,0)
    

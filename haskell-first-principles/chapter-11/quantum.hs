module Quantum where

data Quantum = Yes | No | Both deriving (Eq, Show)

quantSum :: Either Quantum Quantum
quantSum = Right Yes
quantSum2 :: Either Quantum Quantum
quantSum2 = Right No
quantSum3 :: Either Quantum Quantum
quantSum3 = Right Both
quantSum4 :: Either Quantum Quantum
quantSum4 = Left Yes
quantSum5 :: Either Quantum Quantum
quantSum5 = Left No
quantSum6 :: Either Quantum Quantum
quantSum6 = Left Both

-- And now the arithmetic of product types:

quantProd1 :: (Quantum, Quantum)
quantProd1 = (Yes, Yes)
quantProd2 :: (Quantum, Quantum)
quantProd2 = (Yes, No)
quantProd3 :: (Quantum, Quantum)
quantProd3 = (Yes, Both)
quantProd4 :: (Quantum, Quantum)
quantProd4 = (No, Yes)
quantProd5 :: (Quantum, Quantum)
quantProd5 = (No, No)
quantProd6 :: (Quantum, Quantum)
quantProd6 = (No, Both)
quantProd7 :: (Quantum, Quantum)
quantProd7 = (Both, Yes)
quantProd8 :: (Quantum, Quantum)
quantProd8 = (Both, No)
quantProd9 :: (Quantum, Quantum)
quantProd9 = (Both, Both)

-- And now a function type. Each possible unique implementation of the function is an inhabitant:

quantFlip1 :: Quantum -> Quantum
quantFlip1 Yes = Yes
quantFlip1 No = Yes
quantFlip1 Both = Yes
quantFlip2 :: Quantum -> Quantum
quantFlip2 Yes = Yes
quantFlip2 No = Yes
quantFlip2 Both = No
quantFlip3 :: Quantum -> Quantum
quantFlip3 Yes = Yes
quantFlip3 No = Yes
quantFlip3 Both = Both
quantFlip4 :: Quantum -> Quantum
quantFlip4 Yes = Yes
quantFlip4 No = No
quantFlip4 Both = Yes
quantFlip5 :: Quantum -> Quantum
quantFlip5 Yes = Yes
quantFlip5 No = Both
quantFlip5 Both = Yes
quantFlip6 :: Quantum -> Quantum
quantFlip6 Yes = No
quantFlip6 No = Yes
quantFlip6 Both = Yes
quantFlip7 :: Quantum -> Quantum
quantFlip7 Yes = Both
quantFlip7 No = Yes
quantFlip7 Both = Yes
quantFlip8 :: Quantum -> Quantum
quantFlip8 Yes = Both
quantFlip8 No = Yes
quantFlip8 Both = No
quantFlip9 :: Quantum -> Quantum
quantFlip9 Yes = Both
quantFlip9 No = No
quantFlip9 Both = No
quantFlip10 :: Quantum -> Quantum
quantFlip10 Yes = Both
quantFlip10 No = No
quantFlip10 Both = Both

-- Exponentiation in what order?
-- Consider the following function:

convert1 :: Quantum -> Bool
convert1 Yes  = True
convert1 No   = False
convert1 Both = False
convert2 :: Quantum -> Bool
convert2 No   = True
convert2 Yes  = False
convert2 Both = False
convert3 :: Quantum -> Bool
convert3 Both = True
convert3 Yes  = False
convert3 No   = False
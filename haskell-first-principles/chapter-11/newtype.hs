{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- {-# LANGUAGE DeriveAnyClass #-}
module Unary where

import Data.Char(toUpper)

class TooMany a where
    tooMany :: a -> Bool

instance TooMany Integer where
   tooMany n = n > 42

instance TooMany (Int, [Char]) where
    tooMany  (n, _) = n > 42

-- instance TooMany (Integer,Integer) where
--     tooMany (a,b) = (a + b) == (a + b)

instance (Num a, TooMany a) => TooMany (a, a) where
    tooMany (a,b) = tooMany (a + b) == tooMany (a * b)

instance Eq Goats where
    Goats _ == Goats _ = True

newtype Example = MakeExample Int deriving (Eq,Show)
newtype Goats = Goats Integer deriving (Show,TooMany)
newtype Sheep   = Sheep Int deriving (Eq,Show)
newtype Cow     = Cow Int deriving (Eq,Show)

tooMuchCow :: Cow -> String
tooMuchCow (Cow n ) = if n > 100 then map toUpper "Cows will rain supreme! WORLD DOM-MOO-NATION!" else "not enough Cows..."

tooMuchSheep :: Sheep -> Bool
tooMuchSheep (Sheep n) = n > 42
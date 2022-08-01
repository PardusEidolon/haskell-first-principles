module RandomGen where

import Test.QuickCheck
import Test.Hspec

data Fool = Fulse |Frue deriving (Eq, Show)

-- instance Arbitrary Fool where
--     arbitrary = foolGen

-- foolGen :: Gen Fool
-- foolGen = elements [Fulse,Frue]

fulseGen :: Gen Fool
fulseGen = return Fulse

frueGen :: Gen Fool
frueGen = return Frue

foolGen' :: Gen Fool
foolGen' = frequency [(2,fulseGen),(1,frueGen)]
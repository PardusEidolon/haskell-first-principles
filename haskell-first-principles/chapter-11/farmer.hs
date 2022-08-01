module Farmer where

type Name = String
newtype Acres = Acres Int deriving Show
-- FarmerType is a Sum
data FarmerType = DairyFarmer | WheatFarmer | SoybeanFarmer deriving Show
-- Farmer is a plain ole product of
-- Name, Acres, and FarmerType
data Farmer = Farmer Name Acres FarmerType deriving Show
-- record syntax version
data FarmerRec =
        FarmerRec { name :: Name
                  , acres :: Acres
                  , farmerType :: FarmerType }
                  deriving Show

isDairyFarmer :: Farmer -> Bool
isDairyFarmer (Farmer _ _ DairyFarmer) = True
isDairyFarmer _ = False

farmer1 :: FarmerRec
farmer1 = FarmerRec ("McDonald") (Acres 152) (DairyFarmer)

-- so we can deconstruct values from records to pattern match in a case expression, farmerType jsut being one of the records in the datatype.
isDairyFarmerRec :: FarmerRec -> Bool 
isDairyFarmerRec farmer = case farmerType farmer of
                          DairyFarmer -> True 
                          _           -> False
module TypesAndData where

import VehicleTypes

seven47 :: Vehicle
seven47 = Plane Boeing (Price 10000000) (XtraLarge)

veeMs :: Vehicle
veeMs = (Plane Virgin $ Price 15000000) (Large)

airbus319 :: Vehicle
airbus319 = Plane United (Price 5000000) (XtraLarge)

cooper :: Vehicle
cooper = (Car Mini $ Price 96000) (Medium)

db11 :: Vehicle
db11 = (Car Aston $ Price 360000) (Medium)

m3 :: Vehicle
m3 = (Car BMW $ Price 100000) $ Large

carList :: [Vehicle]
carList   = [cooper,db11,m3]

planeList :: [Vehicle]
planeList = [airbus319,veeMs,seven47] 

-- Define Functions here;
-- Var 1
-- pattern match on car and ignore all other arguments to the type
isCar :: Vehicle -> Bool
isCar (Car _ _ _) = True 
isCar _         = False

isPlane :: Vehicle -> Bool
isPlane (Plane _ _ _ ) = True
isPlane _            = False

areCars :: [Vehicle] -> [Bool]
areCars ls = map isCar ls


getManu :: Vehicle -> [Char]
getManu (Car m _ _) = show m
getManu (Plane m _ _)   = show m

getSize :: Vehicle -> IO()
getSize (Car _ _ s) = putStrLn $ show s
getSize (Plane _ _ s) = putStrLn $ show s

getPrice :: Vehicle -> Price
getPrice (Car _ p _) = p
getPrice (Plane _ p _) = p


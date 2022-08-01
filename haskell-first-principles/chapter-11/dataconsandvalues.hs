module DataConsAndValues where

data PugType = PugData deriving (Show,Eq,Bounded)

data HuskyType a = HuskyData deriving Show

data DogueDeBordeaux a = DogueDeBordeaux a deriving Show

data Doggies a = Husky a | Mastiff a deriving (Eq, Show)

myPug :: PugType
myPug = PugData

myHusky :: HuskyType a
myHusky = HuskyData

myOtherHusky :: Num a => HuskyType a
myOtherHusky = HuskyData

myDoge :: DogueDeBordeaux Int
myDoge = DogueDeBordeaux 10

badDoge :: DogueDeBordeaux String
badDoge = DogueDeBordeaux "Much wow"
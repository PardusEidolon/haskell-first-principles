module MaybeCow where

import Control.Applicative

data Cow = Cow {
    name :: String,
    age :: Int,
    weight :: Int
} deriving (Show,Eq)

noEmpty :: String -> Maybe String
noEmpty "" = Nothing
noEmpty s  = Just s

noNegative :: Int -> Maybe Int
noNegative n
    | n >= 0 = Just n
    | otherwise = Nothing

cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString name age weight = liftA3 Cow (noEmpty name) (noNegative age) (noNegative weight)

anotherCow :: String -> Int -> Int -> Maybe Cow
anotherCow name age weight = (fmap Cow (noEmpty name)) <*> (noNegative age) <*> (noNegative weight)

-- you can just throw together more tie fighters if you have  type that takes more than 3 arguments.
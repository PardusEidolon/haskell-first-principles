module MoreKinds where

data Example a = Blah | RoofGoats | Woot a deriving (Show,Eq)

newtype Example2 a = Black Int deriving (Show,Eq)

data Unary = Unary | UnaryC Int deriving Show

foo :: Int -> Maybe Int
foo 1 = Just 1
foo _ = Nothing
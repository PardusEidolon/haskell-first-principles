module EnumFromtoWut where

import Data.List (intersperse)

data Affirmative = Yes | No deriving (Show,Eq,Ord,Enum) 

eftBool :: Affirmative -> Affirmative -> [Affirmative]
eftBool x y = enumFromTo x y

eftOrd :: Ordering -> Ordering -> Maybe [Ordering]
eftOrd LT LT = Nothing
eftOrd EQ EQ = Nothing
eftOrd GT GT = Nothing
eftOrd x y = Just $ enumFromThen x y

eftInt :: Int -> Int -> [Int]
eftInt x y = take x . map (*2) . enumFromThen 10 $ y

eftChar :: Char -> Char -> [Char]
eftChar x y = intersperse x . enumFromTo 'a' $ y

module SumOfThree where

data SumOfThree a b c = 
    First a | Second b | Third c deriving (Eq,Show)

sumMatch :: SumOfThree a b c -> Bool
sumMatch (First _) = True
sumMatch _ = False

allSumMatch :: SumOfThree a b c -> String
allSumMatch (First _) = "This is a First"
allSumMatch (Second _)= "This is a Second"
allSumMatch (Third _) = "This is a Third"

-- comp'n it

-- comp :: (Bool -> Char) -> ((Char-> Bool) -> (Int -> Char))
-- comp f g x = f (g x)

charBool :: Char -> Bool
charBool x = x == 'a'

intChar :: Int -> Char
intChar 1 = 'a'
intChar 0 = 'f'
intChar _ = 'z'

boolChar :: Bool -> [Char]
boolChar True = "Hey there"
boolChar _  = "zzzzz"
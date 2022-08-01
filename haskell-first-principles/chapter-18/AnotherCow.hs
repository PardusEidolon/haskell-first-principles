module AnotherCow where

data Cow = Cow { 
            name   :: String
          , age    :: Int
          , weight :: Int
          } deriving (Eq,Show)

noEmpty :: String -> Maybe String
noEmpty "" = Nothing
noEmpty str = Just str

noNegative :: Int -> Maybe Int
noNegative n 
        | n >= 0 = Just n
        | otherwise = Nothing

weightCheck :: Cow -> Maybe Cow
weightCheck c = 
    let w = weight c
        n = name c
    in if n == "Bess" && w > 499
        then Nothing
        else Just c

mkCow :: String -> Int -> Int -> Maybe Cow
mkCow n a w= do
    name <- noEmpty n
    age <- noNegative a
    weight <- noNegative w
    weightCheck (Cow name age weight)
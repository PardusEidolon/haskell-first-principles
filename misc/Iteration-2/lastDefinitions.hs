module LastDefs where

data Nada = Nada Double 
   deriving (Eq, Show)

instance Num Nada where
  (Nada x) + (Nada y) = Nada (x + y)
  (Nada x) - (Nada y) = Nada (x - y)
  (Nada x) * (Nada y) = Nada (x * y)
  negate (Nada x) = Nada (negate x)

instance Fractional Nada where
    (Nada x) / (Nada y) = Nada (x / y)

bindExp :: a -> String
bindExp _ = 
    let x = 10; y = 5 in
    "the integer was: " ++ show x
    ++ " and y was: " ++ show y

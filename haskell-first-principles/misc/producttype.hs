module ProductTypes where

newtype Affirmative = Affirmative Integer deriving (Show,Eq,Ord)

newtype Negative = Negative Integer deriving (Show,Eq,Ord)

data BoolInt = Yes Affirmative | No Negative deriving (Show,Eq,Ord)

data Confirmation = Correct | Incorrect deriving (Show,Eq,Ord)

foo :: BoolInt
foo = Yes $ Affirmative 1

bar :: BoolInt
bar = No $ Negative 0

initalConfirmation :: Confirmation -> BoolInt
initalConfirmation Correct = foo
initalConfirmation Incorrect = bar

fooBar :: BoolInt -> Confirmation
fooBar (Yes (Affirmative 1)) = Correct
fooBar _ = Incorrect
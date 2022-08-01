module GimmePerson where

type Name = String
type Age = Integer


data Person = Person Name Age deriving Show
data PersonInvalid = NameEmpty | AgeTooLow | PersonInvalidUnknown String deriving (Eq, Show)


mkPerson :: Name -> Age -> Either PersonInvalid Person
mkPerson name age
    | name /= "" && age > 0 = Right $ Person name age
    | name == "" = Left NameEmpty
    | not (age > 0) = Left AgeTooLow
    | otherwise = 
        Left $ PersonInvalidUnknown $
            "Name was: " ++ show name ++
            " Age was: " ++ show age

gimmePerson :: IO ()
gimmePerson = do
    putStr "your name is: "
    name <- getLine
    putStr "your age is: "
    age <- fmap read getLine
    case mkPerson name age of
        Left a  -> putStrLn ("**error** could not create dude" ++ show a)
        Right b -> putStrLn ("congradulations you had a " ++ show b)

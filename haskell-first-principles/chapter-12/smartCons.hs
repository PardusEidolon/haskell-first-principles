module SmartCons where

data Person = Person Name Age deriving (Eq,Show)

data PersonInvalid = InvalidName | AgeTooLow deriving (Eq,Show)

type Name = String
type Age  = Integer

type ValidatePerson a = Either [PersonInvalid] a

-- mkPerson :: Person -> Either PersonInvalid Person
-- mkPerson (Person n a)
--     | n /= "" && a >= 0 = Right (Person n a)
--     | n == "" =  Left NameEmpty
--     | otherwise = Left AgeTooLow

--  Stated from the bottom now where here

mkPerson :: Name -> Age -> ValidatePerson Person
mkPerson name age = mkPerson' (nameOkay name) (ageOkay age)

mkPerson' :: ValidatePerson Name -> ValidatePerson Age -> ValidatePerson Person
mkPerson' (Right nameOk) (Right ageOk) = Right (Person nameOk ageOk)
mkPerson' (Left invalidName) (Left ageTooLow) = Left (invalidName ++ ageTooLow)
mkPerson' (Left invalidName)  _            = Left invalidName
mkPerson'  _             (Left ageTooLow) = Left ageTooLow


ageOkay :: Age -> Either [PersonInvalid] Age
ageOkay  age = case age >= 0 of
        True -> Right age
        False -> Left [AgeTooLow]

-- nameOkay :: Name -> Either [PersonInvalid] Name
-- nameOkay name = case name /= "" of
--         True -> Right name
--         False -> Left [NameEmpty]

-- I wonder if there is a way to filter out the numbers in names unless your elons musk's son X Æ A-Xii or some wierd shit.

nameOkay :: Name -> Either [PersonInvalid] Name
nameOkay name
    | name == "" = Left [InvalidName]
    | not . foldr (\a b -> b || a) False $ nameMap name = Right name
    | foldr (\a b -> b || a) False $ nameMap name = error "Name cannot contain numbers!"
    | otherwise = Left [InvalidName]

nameMap :: Name -> [Bool]
nameMap n = map (\x -> elem x ['0'..'9'] ) n


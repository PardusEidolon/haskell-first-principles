module MaybePerson where

import Control.Applicative

newtype Name = Name String deriving (Eq,Show)
newtype Address = Address String deriving (Eq,Show)

data Person = Person Name Address deriving (Eq,Show)

instance Monoid Name where
    mempty = Name mempty
    mappend = (<>)

instance Monoid Address where
    mempty = Address mempty
    mappend = (<>)

instance Semigroup Name where
    (<>) (Name a) (Name b) = Name (a <> b)

instance Semigroup Address where
    (<>) (Address a) (Address b) = Address (a <> b)

instance Semigroup Person where
    (<>) (Person a b) (Person a' b') = Person (a <> a') (b <> b')

-- instance Functor Name where
--     fmap f (Name a) = Name (f a)

-- instance Functor Person where
    -- fmap f (Person a b) = Person (fmap f a) (fmap f b)

validateLength :: Int -> String -> Maybe String
validateLength maxLen s = 
    if (length s) > maxLen
        then Nothing 
        else Just s

mkName :: String -> Maybe Name
mkName s = fmap Name $ validateLength 25 s

mkAddress :: String -> Maybe Address
mkAddress s = fmap Address $ validateLength 100 s

mkPerson :: String -> String -> Maybe Person
mkPerson n a = fmap Person (mkName n) <*> (mkAddress a)

anotherPerson :: String -> String -> Maybe Person
anotherPerson name adress = liftA2 Person (mkName name) (mkAddress adress)

yetAnotherPerson :: String -> String -> Maybe Person
yetAnotherPerson n a = (<*>) (fmap Person (mkName n)) (mkAddress a)

-- following the interchange law!
interChangePerson :: String -> String -> Maybe Person
interChangePerson n a = Just ($ Address a) <*> Just (Person (Name n))
-- our structured function on the right is partially applyed to the first arguemnt name of the type Person were lifing the  data constrcutor Just
-- on our left were sectioning a value Adress with the dolla symbol and then applying it to the partially applued function on the right


person1 :: Person
person1 = Person (Name "Jeff") (Address "21 Jump Street")

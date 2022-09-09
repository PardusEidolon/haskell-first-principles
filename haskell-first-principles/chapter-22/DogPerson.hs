module DogPerson where

newtype HumanName = HumanName String deriving (Eq,Show)
newtype Address = Address String deriving (Eq, Show)
newtype DogName = DogName String deriving (Eq, Show)

newtype Reader r a = Reader { runReader :: r -> a }

data Person = Person {
    humanName :: HumanName
  , dogName :: DogName
  , address :: Address
} deriving (Eq,Show)

data Dog = Dog {
    dogsName :: DogName
  , dogsAddress :: Address
} deriving (Eq, Show)

instance Functor (Reader r) where
    fmap f (Reader ra) = Reader (\r -> f (ra r))

instance Applicative (Reader ra) where
    pure a = Reader $ const a
    (<*>) (Reader rab) (Reader ra) = Reader $ \r -> rab r $ ra r

instance Monad (Reader ra) where
    return = pure
    (Reader rab) >>= ram = Reader $ \r -> runReader (ram (rab r)) r

asks :: (a -> b) -> Reader a b
asks f = Reader f

pers :: Person 
pers = Person (HumanName "Big Bird") (DogName "Barkley") (Address "Sesame Street")

chris :: Person 
chris = Person (HumanName "Chris Allen") (DogName "Papu") (Address "Austin")

-- without Reader 
getDog :: Person -> Dog 
getDog p = Dog (dogName p) (address p)

-- with Reader 
getDogR :: Person -> Dog 
getDogR = Dog <$> dogName <*> address

-- (a -> b) -> (f -> a) -> (b -> c) -> c 

getDogRm :: Reader Person Dog
getDogRm = do
  name <- asks dogName
  addy <- asks address
  return $ Dog name addy
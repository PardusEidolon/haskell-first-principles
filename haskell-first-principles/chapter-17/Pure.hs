module Pure where

data Class a = Class a | Abscent deriving (Show,Eq)

instance Semigroup a => Semigroup (Class a) where
    (<>) _ Abscent = Abscent
    (<>) Abscent _ = Abscent
    (<>) (Class a) (Class a') = Class (a <> a')

instance Monoid a => Monoid (Class a) where
    mempty = Abscent
    mappend = (<>)

instance Functor Class where
    fmap _ Abscent = Abscent
    fmap f (Class a) = Class (f a)

instance Applicative Class where
    pure = Class
    Abscent <*> _ = Abscent
    _ <*> Abscent = Abscent
    Class f <*> Class a = Class (f a) 

-- Pure is just a way of giving something a base structure here for us to lift over. 
-- A genral form of structure might i add, so you can think of it as just a function that adapts to the type that it's applying too.

foo :: [Int]
foo = pure 1

baz :: Maybe Int
baz = pure 0

bar :: Either a Int
bar = pure 1

carol :: [Bool]
carol = pure (1 == 1)

tupl :: ([a],Int)
tupl = pure 0

f :: [Integer]
f = [(+1),(+2)] <*> pure 1

f' :: [Integer]
f' = pure ($ 1) <*> [(+1),(+2)]

faz :: Maybe Integer
faz = Just (+1) <*> pure 1

fazzy :: Maybe Integer
fazzy = pure ($ 1) <*> Just (+1)

-- laws:
-- Identity
-- Composability
-- Homomorphism
-- Interchangabilty
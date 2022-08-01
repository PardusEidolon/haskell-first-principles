module UnappliedType where

data Two a b = Two a b deriving (Show,Eq)

newtype One a = One a deriving (Show,Eq)

data Or a b = ThisOne a | OrThis b deriving (Show, Eq)

data Wrap f a = Wrap (f a) deriving (Show, Eq) -- heres a weird one where the structure is part of the type

instance Functor (Or a) where -- here we see another example but this time with a type that uses logical disjunction
    fmap _ (ThisOne a) = ThisOne a -- in the case of logical disjunction one of the data constructors must be out identity value
    fmap f (OrThis b) = OrThis (f b)

instance Functor (Two a) where -- we have to make the first argument apart of the structure so can make it from * -> * -> * to * -> *
    fmap f (Two a b) = Two a (f b) --functors only work on the kinds: * -> *
    -- this is an example of an instance with 2 arguments without (Or: logical disjunction)

instance Functor One where
    fmap f (One a) = One (f a)

instance Functor f => Functor (Wrap f) where
    fmap f (Wrap fa) = Wrap (fmap f fa)

instance Semigroup a => Semigroup (One a) where
    (<>) (One a) (One b) = One (a <> b)

instance Monoid a => Monoid (One a) where
    mempty = One mempty
    mappend = (<>)

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
    (<>) (Two a b) (Two a' b') = Two (a <> a') (b <> b')

instance (Monoid a, Monoid b) => Monoid (Two a b) where
    mempty = Two mempty mempty
    mappend = (<>)
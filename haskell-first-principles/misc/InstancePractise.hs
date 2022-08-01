module InstancePractise where

data Trivial = Trivial -- isntances for type with no arguments with a nullary type constructor; not much here

instance Show Trivial where
    show Trivial = "Trivial"

instance Eq Trivial where
    Trivial == Trivial = True

instance Semigroup Trivial where
    (<>) Trivial Trivial = Trivial

instance Monoid Trivial where
    mempty = Trivial
    mappend = (<>)

newtype Pen a = Pen {peny :: a} deriving Show -- instances for a newtype that takes a single argument; unary

instance Eq a => Eq (Pen a) where
    (Pen a) == (Pen a') = a == a'

-- instance Butt (Pen a) where
--     cheeks (Pen a) (Pen _) = Pen a

instance Semigroup a => Semigroup (Pen a) where
    (<>) (Pen a) (Pen b) = Pen (a <> b)

instance Monoid a => Monoid (Pen a) where
    mempty = Pen mempty
    mappend = (<>)
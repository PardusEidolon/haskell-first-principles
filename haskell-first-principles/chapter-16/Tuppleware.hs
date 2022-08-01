module TuppleWare where

data Morty a b = Morty a | Rick b deriving (Eq,Show)

instance Functor (Morty a) where
    fmap _ (Morty a) = Morty a
    fmap f (Rick b)  = Rick (f b)

instance (Semigroup a, Semigroup b) => Semigroup (Morty a b) where
    (<>) (Rick a) (Rick b) = Rick (a <> b)
    (<>) (Morty a) (Morty b) = Morty (a <> b)
    (<>)  (Rick a) _ = Rick a
    (<>) _      (Rick a) = Rick a

instance (Monoid a, Monoid b) => Monoid (Morty a b) where
    mempty = Morty mempty
    mappend = (<>)
module Instance_practise1 where
------------------------------------------------------------

data Bonk a = Bonk {entry1 :: a} | Gronk deriving (Eq,Show)

instance Monoid a => Monoid (Bonk a) where
    mempty = Gronk
    mappend = (<>)

instance Semigroup a => Semigroup (Bonk a) where
    (<>) _ Gronk = Gronk
    (<>) Gronk _ = Gronk
    (<>) (Bonk a) (Bonk b) = Bonk (a <> b)

instance Functor Bonk where
    fmap f Gronk = Gronk
    fmap f (Bonk a) = Bonk (f a)

instance Applicative Bonk where
    pure = Bonk
    (<*>) _ Gronk = Gronk
    (<*>) Gronk _ = Gronk
    (<*>) (Bonk f) (Bonk a) = Bonk (f a)
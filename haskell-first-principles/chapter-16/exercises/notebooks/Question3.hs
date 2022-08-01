module Question3 where
-- 3.
data SomethingElse a = Falsish | Truish a deriving (Show,Eq)

instance Functor SomethingElse where
    fmap _ Falsish = Falsish
    fmap f (Truish a) = Truish (f a)

fmap id Falsish == Falsish 
    
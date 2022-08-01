module ConstantlyConstant where

newtype Constant a b = 
    Constant {getConstant :: a } 
    deriving (Eq,Ord,Show)

-- 'a' is apart of the strucutre giving it a kind of * -> * but also making it invalid because were ghosting the second argument!
-- because 'b' is being ghosted we cant really apply/transform anything here unless we flip it or swap the type arguments around
instance Functor (Constant a) where
    fmap _ (Constant a) = Constant a

-- because we made the arguemt 'a' have an instance of monoid. here we can use things like mempty and the '<>' (mappend) operator
-- using a functor instance would be no hope as you can see in the above instance.
-- so instead the only thing we can do is lift and smoush the two values 
instance Monoid a => Applicative (Constant a) where
    pure a = Constant mempty 
    (<*>) (Constant f) (Constant a) = Constant (f <> a)
module ReadingComp where

newtype Reader r a = Reader { runReader :: r -> a }

instance Functor (Reader r) where
    -- fmap f (Reader ra) = Reader (f . ra)
    fmap f (Reader ra) = Reader (\r -> f (ra r))

instance Applicative (Reader ra) where
    pure a = Reader $ const a
    (<*>) (Reader rab) (Reader ra) = Reader $ \r -> rab r $ ra r
--  (r -> a -> b) -> (r -> a) -> (r -> b) -- the first arg needs 2 inputs 
--  r (a -> b) -> r a -> r b
-- looks similar right?

instance Monad (Reader ra) where
    return = pure
    (Reader rab) >>= ram = Reader $ \r -> runReader (ram (rab r)) r
-- (r -> a) -> (a -> r -> b) -> (r -> b)
--  Reader words >>= return = Reader $ \r -> runReader (return (words r)) r 
myLiftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
myLiftA2 f fa fb = f <$> fa <*> fb

-- a monadic one ... because why not?
myLiftA2' :: Monad f => (a -> b -> c) -> f a -> f b -> f c
myLiftA2' f fa fb = do
    a <- fa
    fmap (f a) fb

-- (a -> b -> c) -> (f -> a) -> (f -> b) -> (f -> c)

-- an example with numbers and addition
-- because the sum operator (+) is right associative...
-- applicative  aw was applying both functions to the one argument as arguments to the (+) function
-- functions of functions let the compiler read the composition to reduce the ammount of parameter overhead
-- (3*2) + (3+10)
-- this is what applicaive also does with reader by the way

asks :: (a -> b) -> Reader a b
asks = Reader
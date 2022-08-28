module ChapterExercises where

import Data.Monoid

data Constant a b = Constant b deriving Show

instance Semigroup b => Semigroup (Constant a b) where
    (<>) (Constant a) (Constant b) = Constant (a <> b)

instance Monoid b => Monoid (Constant a b) where
    mempty = Constant mempty
    mappend = (<>)

instance Foldable (Constant a) where
    foldMap f (Constant a) = f a

foo :: [Constant String (Sum Int)]
foo = [Constant (Sum 2), Constant (Sum 4)]

-- 2.

data Two a b = Two a b deriving Show

instance Foldable (Two a) where
    foldMap f (Two a1 a2) = f a2

-- 3.

data Three a b c = Three a b c deriving Show

instance Foldable (Three a b) where
    foldMap f (Three a1 a2 a3) = f a3

-- 4.

data Three' a b = Three' a b b deriving Show

instance Foldable (Three' a) where
    foldMap f (Three' a1 a2 a2') = f a2 <> f a2'

-- 5.

data Four' a b = Four' a b b b deriving Show

instance Foldable (Four' a) where
    foldMap f (Four' a b1 b2 b3) = (f b1) <> (f b2) <> (f b3)

-- 6.
-- Thinking cap time. Write a filter function for Foldable types using foldMap.

-- foldMap :: (Foldable t, Monoid m) => (a -> m) -> t a -> m
-- filter :: (a -> Bool) -> [a] -> [a]
-- monoids join 2 structures together (a binary associative operation with an identity value) <> TLDR; Just combine structure

filterMap :: (Monad m, Foldable t, Monoid (m a)) =>  (a -> Bool) -> t a -> m a 
filterMap f ta = foldMap go ta
    where
        go x = if f x then return x else mempty
    
filterMap2 :: (Monad m, Foldable t, Monoid (m a)) =>  (a -> Bool) -> t a -> m a 
filterMap2 f ta = foldMap go ta
    where
        go x
            | f x == True = return x
            | otherwise = mempty 

filterMap3 :: (Monad m, Foldable t, Monoid (m a)) =>  (a -> Bool) -> t a -> m a 
filterMap3 f ta = foldMap go ta
    where
        go x = case f x of
          False -> mempty
          True -> return x

filterMap4 :: (Monad m, Foldable t, Monoid (m a)) =>  (a -> Bool) -> t a -> m a 
filterMap4 f ta = foldMap go ta
    where
        go = (\x -> if f x then return x else mempty)

-- (\x -> if f x then retrn x else mempty)
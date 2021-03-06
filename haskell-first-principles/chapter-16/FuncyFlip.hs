{-# LANGUAGE FlexibleInstances #-}
module FuncyFlip where

-- depending on the datatype were going to fet some really unique shit

data Tuple a b = Tuple a b deriving (Eq,Show)

newtype Flip f a b = Flip (f b a) deriving (Eq,Show)

instance Functor (Flip Tuple a) where
    fmap f (Flip (Tuple a b)) = Flip $ Tuple (f a) b
module Mood where

data Mood = Yeet | Woot deriving Show

changeMood :: Mood -> Mood
changeMood Yeet = Woot
changeMood    _ = Yeet

-- A equivilent example of below

changeBool :: Bool -> Bool
changeBool True = False
changeBool False = True
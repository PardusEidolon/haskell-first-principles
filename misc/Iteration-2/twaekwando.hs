module Twaekwando where

{-
Type-Kwon-Do

The name is courtesy of Phillip Wright.3 Thank you for the idea!
The focus here is on manipulating terms in order to get the types
to fit. This sort of exercise is something you’ll encounter in writing
real Haskell code, so the practice will make it easier to deal with
when you get there. Practicing this will make you better at writing
ordinary code as well.

We provide the types and bottomed out (declared as undefined)
terms. Bottom and undefined will be explained in more detail later.
The contents of the terms are irrelevant here. You’ll use only the
declarations provided and what the Prelude provides by default
unless otherwise specified. Your goal is to make the ???’d declaration
pass the typechecker by modifying it alone.
-}

data Woot

data Blah

f :: Woot -> Blah
f = undefined

g :: (Blah, Woot) -> (Blah, Blah)
g (b, w) = (b, f w)

f' :: Int -> String
f' = undefined

g' :: String -> Char
g' = undefined

h :: Int -> Char
h i = g' $ f' i

--- 2)

data A
data B
data C

q :: A -> B
q = undefined

w :: B -> C
w = undefined

e' :: A -> C
e' x = w $ q x

--- 3)

data X
data Y
data Z

xz :: X -> Z
xz = undefined

yz :: Y -> Z
yz = undefined

xform :: (X, Y) -> (Z, Z)
xform (x, y) = (xz x, yz y)

--- 4)

munge :: (x -> y) -> (y -> (w, z)) -> x -> w
munge xy ywz x = fst $ ywz $ xy x

module Inference where

id' x y = x ++ y

f :: Num a => a -> a -> a
f x y = x + y + 3

--- Apply yourself to these exercises

---1. Just a general function here sir, nothing to worry about.
--- (++) :: [a]->[a]->[a]

--- we have applied this to the type of [char] or a "String". So the function is now more concrete or less polymorphic than say, using just abstract variables.
myConcat x = (++) x "yo"

---2. another general function nothing to worry about.
---(*) :: Num a => a -> a -> a

--- So when we apply this operator to a number with the type fractional which is of the class num then we'll find that it is now more contrained than its polymorphic counterpart.
myMult x = (x / 3) * 5

--take :: Int -> [a] -> [a]

--- as you can see we have now defined that he list a is of the type [Char].
myTake x = take x "hey you"

--- (>) :: Ord a => a -> a -> Bool

--- the ghc is able to recognise that the function length gives us an out of int so the only way were going to compare two vaulues is with the type Int.
myCom x = x > (length [1..50])

---  having a type of char in the mix has contrained the function to the type of char and only char
myAlph x = x < 'z'
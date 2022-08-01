module Newtypes where

{-
While we haven’t fully explained this syntax yet, you’ve seen it
in Chapter 2 and as a solution to an exercise in Chapter 4. This
syntax is a way of destructuring a single element of a list by 
pattern matching.
-}

functionH :: [a] -> a
functionH (x:_) = x 

functionC :: String -> String -> Bool
functionC x y = 
    if ( x > y) then True else False

functionS :: Num a => (a,b) -> b
functionS (x, y) = y


{-
You will be shown a type and a function that needs to be written. Use
the information the type provides to determine what the function
should do. We’ll also tell you how many ways there are to write
the function. Syntactically different but semantically equivalent
implementations are not counted as being different. For example,
writing a function one way then rewriting the semantically identical
function but using anonymous lambda syntax does not count as two
implementations.
-}

i :: a -> a
i a = a

c :: a -> b -> a
c a _ = a

c' :: a -> b -> a
c' a b = a

c'' :: a -> b -> b
c'' _ b = b

r :: [a] -> [a]
r = tail

co :: (a,b) -> (c,d) -> (a,c)
co (a,b) (c,d) = (a,c)

a :: (a -> c) -> a -> a
a ac a = a

a' :: (a -> b) -> a -> b
a' ab = ab

{-
Fix it

Won’t someone take pity on this poor broken code and fix it up? Be
sure to check carefully for things like capitalization, parentheses, and
indentation.
-}

fstString :: [Char] -> [Char]
fstString x = x ++ " in the rain"

sndString :: [Char] -> [Char]
sndString x = x ++ " over the rainbow"

sing = if (x < y) then fstString x else sndString y
    where x = "Singin"
          y = "Somewhere"

-- arith3broken.hs
main :: IO ()
main = do    
    print yah
    print 10
    print blah
    print huh
        where blah = negate 1
              yah  = 1 + 2
              huh  = (+0) blah
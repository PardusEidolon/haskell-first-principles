{-# LANGUAGE NoMonomorphismRestriction #-}

module DetermineTheType where

example = 1
--- 1.
a = (*9) 6
b = head [(0,"doge"),(1,"kitten Kong")]
c = head [(0 :: Integer ,"doge"),(1,"kitteh")]
d = False
e = length [1, 2, 3, 4, 5]
f = length [1, 2, 3, 4] > length "TACOCAT"

f' :: [a] -> Bool
f' x = length x > length "tacocat"

---2.
x = 5
y = x + 5
---in its monomorphic form its just an int but because we have an inline in the header the compiler is giving it the most generalised form.
w = y * 10
--- adding a paramenter makes the function local instead of takeing the top level function y thats already in scope.
z y = y * 10
f'' = 4 / y

---5.
x' = "Julie"
y' = "<3"
z' = "Haskell"
fs = x' ++ y' ++ z'
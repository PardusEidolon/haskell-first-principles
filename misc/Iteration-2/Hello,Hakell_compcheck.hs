module Hellohaskell where

--- #Comprehension Check

half x = x /2
square x = x * x

-- These functions can be written in the REPL with the prefix operator "let" before the function name then followed by the expression.
-- but as of the latest version of the GHCI we no longer need to do this we can simply just define the functions as is above.

pie x = pi * (x * x)
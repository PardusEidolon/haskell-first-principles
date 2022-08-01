module Factorial where

inc :: Num a => a -> a
inc = (+1)

trippleThrees = inc . inc . inc
--              (+1) + (+1) + (+1) + x
--                               x = 10

incTimes :: (Eq a, Num a) => a -> a -> a
incTimes 0 n = n
incTimes times n = 1 + incTimes (times - 1) n

-- let me explain how this bottom function is working, by creating a second condition on top were telling haskell the recursive fucntion when to stop.
-- the bottom function takes 2 variables times and n and if times - 1 is == to 0 in our first condition then return n else 1 + the result of times - 1.
-- if we didnt put the top condition in it would throw an exeception. Its like the match all case _ if you throw that ontop of any condition your 
-- trying to match, it will just throw an exception.

-- like in the lambda calculus if a condition wasnt put in place above to tell it when to stop it would just diverge.

applyTimes :: (Eq a , Num a) => a -> (b -> b) -> b -> b
applyTimes 0 f b = b
applyTimes n f b = f $ applyTimes (n-1) f b

-- applyTimes 5 (+5) 5 = (+5) (applyTimes (5-1) (+5) 5)
--                     (+5(+5)(applyTimes (4-1) (+5) 5)
--                  (+5(+5(+5)(applyTimes (3-1) (+5) 5)))
--              (+5(+5(+5(+5)(applyTimes (2-1) (+5) 5))))
--          (+5(+5(+5(+5(+5)(applyTimes (1-1) (+5) 5)))))
--       (+5(+5(+5(+5(+5(+5)(applyTimes (0) (+5) 5))))))

--       (10(+5(+5(+5(+5)(applyTimes (4) (+5) 10)))))
--          (15(+5(+5(+5)(applyTimes (3) (+5) 15))))
--             (20(+5(+5)(applyTimes (2) (+5) 20)))
--                (25(+5)(applyTimes (1) (+5) 25))
--                   (30)(applyTimes (0) (+5) 30)

-- an alternative way of writing things....

incTimes2 :: (Eq a, Num a) => a -> a -> a
-- incTimes2 0 n = n
incTimes2 times n = applyTimes times (+1) n

applyTimes2Comp :: (Eq a , Num a) => a -> (b -> b) -> b -> b
applyTimes2Comp 0 f b  = b
applyTimes2Comp n f b = f . applyTimes2Comp (n-1) f $ b

-- evalulate appyTimes2Comp 5 (+1) 5
--  n = 5 which is 5 - 1. repeat until we reach zero. n is esstionally our index an how many times we have to apply the function to itself. So as we take away 1 from the 5
--  5 times to reach 0 we also add 5 at the same time to equal 10

-- 5 (+0) 5
-- 4 (+1) 5
-- 3 (+2) 5
-- 2 (+3) 5
-- 1 (+4) 5
-- 0 (+5) 5
-- then 5 + 5
-- 10 because 0 f b = b where f is (+5) and b is 5 = 5

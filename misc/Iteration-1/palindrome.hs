module Palindrome where

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome x =  x == y
            where y = reverse x
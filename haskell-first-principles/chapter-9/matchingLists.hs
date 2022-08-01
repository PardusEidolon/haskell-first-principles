module MatchingLists where

safeTail :: [a] -> Maybe [a]
safeTail []     = Nothing
safeTail (x:[]) = Nothing
safeTail (_:xs) = Just xs

safeHead :: [a] -> Maybe a
safeHead []     = Nothing
safeHead (x:[]) = Nothing
safeHead (xs:_) = Just xs

--  side note the the 'xs' part (xs : _) is the head of our list,, so our first element
-- the second part of our list (_ : xs) is the tail, so any element that is after the head
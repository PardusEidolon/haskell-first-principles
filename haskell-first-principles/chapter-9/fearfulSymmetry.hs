module FearfulSymmetry where

myWords :: [Char] -> [[Char]]
myWords [] = []
myWords (' ':xs) = myWords xs
myWords xs =  takeWhile (/= ' ') xs : myWords (dropWhile (/= ' ') xs)

-- a note: an empty list of chars "" is the same as [] in HOF

myWords2 :: String -> [String]
myWords2 [] = []
myWords2 s = cur : myWords2 rest
  where cur = takeWhile (/= ' ') s
        rest = dropWhile (== ' ') . dropWhile (/= ' ') $ s

-- the function starts off with a couple saftey blocks otherwise it will be a recursive function that has no end! bottom...
-- hense the [] shall return []
-- myWords2 "be safe yo" = "be" : "safe" : yo : []
-- because "be safe yo" is not == to ' ' the condition is true, take the first element "be"
-- then recurse the rest of the chars in the list of chars...
-- so, "safe yo" becuase cur and rest both take our first input s and the result of s is taking "be safe yo" and returns safe yo
-- which then gets fed into our function cur which will only return "safe" and then all were left with is "yo" 
-- so now we have three elements we can use the cons constructor to build a list of lists

firstSen :: [Char]
firstSen = "Tyger Tyger, burning bright\n"
secondSen :: [Char]
secondSen = "In the forests of the night\n"
thirdSen :: [Char]
thirdSen = "What immortal hand or eye\n"
fourthSen :: [Char]
fourthSen = "Could frame thy fearful symmetry?"

sentences :: [Char]
sentences = firstSen ++ secondSen 
         ++ thirdSen ++ fourthSen

myLines :: String -> [String]
myLines [] = []
myLines xs = case dropWhile (== '\n') xs of
                      [] -> []
                      az -> w : myLines rest
                            where (w, rest) = break (== '\n') az

-- Imma try figure this function out, lets see
-- myLines "welcome\n to\n hell\n" | is this lists firt element equal to the '\n' in the list of chars? | no | then return the list | if it is then drop the '\n'
-- else in the case of az contruct a new list from the result of w and myLines rest | where w = "welome" and rest = "\n to\n hell\n" | ("welcome","\n to\n hell\n")
--  is "\n to\n hell\n" == '\n'? | yes, now drop the '\n'| now we have "to\n hell\n" | break "to\n hell\n" into ("to","\n hell\n") | is "\n hell\n" == to '\n' 
-- | yes, now drop it | so that we have "hell\n" | break "hell\n" into ("hell","\n") | az is now "welcome" : "to" : "hell" | back to the beginning myLines "\n"
-- is "\n" == to '\n'? | Yes, so drop it | we now have an empty list of chars "" which will just return [] and once that condition is met we now contruct a list from
-- "welcome" : "to" : "hell" : [] to give us ["welcome"," to"," hell"]

shouldEqual :: [[Char]]
shouldEqual =
    [ "Tyger Tyger, burning bright"
    , "In the forests of the night"
    , "What immortal hand or eye"
    , "Could frame thy fearful symmetry?"
    ]

main :: IO ()
main = putStrLn $
       "all lists are equal in\n"++"the eyes of the god? "
       ++ show (myLines sentences
                == shouldEqual)

myBreak :: Char -> String -> [String]
myBreak _ [] = []
myBreak c s = cur : myBreak c rest
  where cur = takeWhile (/= c) s
        rest = dropWhile (== c) . dropWhile (/= c) $ s

-- break it down time
-- were matching on the argument that is the type Char and contructing a list of strings
-- that break on those char's that were matching on in the list
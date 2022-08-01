module Indopendance where

import Test.QuickCheck
import Test.Hspec
import Data.List
import Data.Char (ord, toUpper)

capitalizeWord :: String -> String
capitalizeWord []     = []
capitalizeWord (c:cs) = toUpper c : cs

twice :: Eq a => (a -> a) -> a -> a
twice f = f . f

fourTimes :: Eq a => (a -> a) -> a -> a
fourTimes = twice . twice 

foo :: String -> Bool
foo x = (capitalizeWord x == twice capitalizeWord x) && (capitalizeWord x == fourTimes capitalizeWord x)

bar :: [Int] -> Bool
bar x = (sort x == twice sort x) && (sort x == fourTimes sort x)

someWords :: Gen String
someWords = elements ["haggis","string","cock","spoodle","scientist","apple","sleep","socks","peanuts","girl","prostate","rectum","SANCTIONS","Tarif","AmErIcA","asshole"]

prop_foo :: Property
prop_foo = forAll someWords foo

prop_bar :: Property
prop_bar = forAll (arbitrary :: Gen [Int]) bar

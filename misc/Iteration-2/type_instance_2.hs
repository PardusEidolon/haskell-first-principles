module Notes where

data DayOfWeek =
  Mon | Tue | Wed | Thu | Fri | Sat | Sun deriving (Eq,Show)

instance Ord DayOfWeek where
    compare Fri Fri = EQ
    compare Fri _   = GT 
    compare _  Fri  = LT
    compare _ _     = EQ

check :: (Show a, Ord a) => a -> a -> Bool
check x y = x == y

x ::Int -> Int
x a = a + 20

printIt :: IO()
printIt = putStrLn (show (x 2))

data Person = Person Bool deriving Show

printPerson :: Person -> IO ()
printPerson x = putStrLn (show x)

{-# Language DefaultSignatures, DeriveAnyClass #-}

data Mood = Blah | Woot deriving (Ord,Eq,Show)

settleDown x = if x > Woot
                  then Blah
                  else x

type Subject = String

type Verb = String

type Object = String

data Sentence = Sentence Subject Verb Object deriving (Eq, Show)

s1 = Sentence "dogs" "drool" "ridgeback"
s2 = Sentence "Julie" "loves" "dogs"
s3 = s1 == s2

data Rocks = Rocks String deriving (Eq, Show)

data Yeah = Yeah Bool deriving (Eq, Show)

data Papu = Papu Rocks Yeah deriving (Eq, Show)

paps' :: Papu
paps' = Papu (Rocks "something") (Yeah True)

papz :: Papu
papz = Papu (Rocks "something") (Yeah True)

equalityForall :: Papu -> Papu -> Bool
equalityForall p p' = p == p'
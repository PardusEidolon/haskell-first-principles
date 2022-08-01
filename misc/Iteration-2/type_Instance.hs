module Typeinstance where

data Trivial'
  = Trivial'

data TisAnInteger
  = TisAn Integer

data TwoIntegers
  = Two Integer Integer deriving Show

data Tuple a b
  = Tuple a b

data StringOrInt
  = TisAnInt Int
  | TisAString String

data Identity a
  = Identity a
  deriving (Show)

data DayOfWeek
  = Mon
  | Tue
  | Wed
  | Thu
  | Fri
  | Sat
  | Sun
  deriving (Ord, Show)

data Date
  = Date DayOfWeek Int
  deriving (Show)

data Pair a
  = Pair a a deriving Show

data Which a
  = ThisOne a
  | ThatOne a

data EitherOr a b
  = Hello a
  | Goodbye b deriving Show

instance Eq Trivial' where
  Trivial' == Trivial' = True

instance Eq DayOfWeek where
  (==) Mon Mon = True
  (==) Tue Tue = True
  (==) Wed Wed = True
  (==) Thu Thu = True
  (==) Fri Fri = True
  (==) Sat Sat = True
  (==) Sun Sun = True
  (==) _ _ = False

instance Eq Date where
  (==)
    (Date weekday dayOfmonth)
    (Date weekday' dayOfmonth') =
      weekday == weekday' && dayOfmonth == dayOfmonth'

instance (Eq a) => Eq (Identity a) where
  (Identity v) == (Identity v') = v == v'

instance Eq TisAnInteger where
  (==) (TisAn x) (TisAn y) =
    x == y

instance Eq TwoIntegers where
  (==) (Two x y) (Two a b) =
    x == y && a == b

instance Eq StringOrInt where
  (==) (TisAnInt x) (TisAnInt y) = x == y
  (==) (TisAString x) (TisAString y) = x == y
  _ == _ = False

instance (Eq a) => Eq (Pair a) where
  (Pair a b) == (Pair c d) = a == b && c == d

instance (Eq a, Eq b) => Eq (Tuple a b) where
  (Tuple a b) == (Tuple c d) = a == c && b == d

instance Eq a => Eq (Which a) where
  (==) (ThisOne x) (ThisOne y) = x == y
  (==) (ThatOne x) (ThatOne y) = x == y
  _ == _ = False

instance (Eq a, Eq b) => Eq (EitherOr a b) where
  (==) (Hello a) (Hello b) = a == b
  (==) (Goodbye a) (Goodbye b) = a == b
  _ == _ = False

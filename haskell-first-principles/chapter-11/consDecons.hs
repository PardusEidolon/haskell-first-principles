module ConstructDeconstruct where

data GuessWhat = Chickenbutt deriving (Eq, Show)
data Id a = MkId a deriving (Eq, Show)
data Product a b = Product a b deriving (Eq, Show)
data Sum a b = First a | Second b deriving (Eq, Show)

data RecordProduct a b =
    RecordProduct { pfirst :: a
                  , psecond :: b }
                  deriving (Eq, Show)


newtype NumCow = NumCow Int deriving (Eq, Show)
newtype NumPig = NumPig Int deriving (Eq, Show)
newtype NumSheep = NumSheep Int deriving (Eq, Show)

data Farmhouse = Farmhouse NumCow NumPig deriving (Eq, Show)

type Farmhouse' = Product NumCow NumPig

data BigFarmhouse = BigFarmhouse NumCow NumPig NumSheep deriving (Eq, Show)

type BigFarmhouse' = Product NumCow (Product NumPig (Product GuessWhat NumSheep))

-- for the above type BigFarmhouse'
-- Constructing Values
trivialValue :: GuessWhat
-- ok, this is trivial
trivialValue = Chickenbutt

nCow :: NumCow
nCow = NumCow 123
nPig :: NumPig
nPig = NumPig 456
nSheep :: NumSheep
nSheep = NumSheep 789

farmArk :: BigFarmhouse'
farmArk = Product nCow (Product nPig (Product trivialValue nSheep))

-- A trick with sums supposedley; are we nesting here?
type Name = String
type Age = Int
type LovesMud = Bool
type PoundsOfWool = Int

data CowInfo = CowInfo Name Age deriving (Eq, Show)
data PigInfo = PigInfo Name Age LovesMud deriving (Eq, Show)
data SheepInfo = SheepInfo Name Age PoundsOfWool deriving (Eq, Show)

data Animal = Cow CowInfo | Pig PigInfo | Sheep SheepInfo deriving (Eq, Show)

-- In another universe
-- NOTE:       🔽 this is a; 🔽 this is b
type Animal' = Sum CowInfo (Sum PigInfo SheepInfo)



--  Declaring vlaues for shorthand
cow :: CowInfo
cow = CowInfo "bess" 12
pig :: PigInfo
pig = PigInfo "Yonko" 2 True
sheep :: SheepInfo
sheep = SheepInfo "poppy" 5 5

-- nested in the First constructor First a of the type Sum
iCow :: Animal'
iCow = First cow
-- nested in the Second constructor Second (First b) of the type Sum
iPig :: Animal'
iPig = Second $ First pig
-- nested in the Seond constructor Second (Second b) of the type Sum
iSheep :: Animal'
iSheep = Second $ Second sheep

--  Record Syntax
myRecord :: RecordProduct Integer Float
myRecord = RecordProduct 42 22.1456


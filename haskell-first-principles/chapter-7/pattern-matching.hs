module PatternMatching where

newtype Username = Username String deriving Show

newtype AccountNumber = AccountNumber Integer deriving Show

data User = UnregisteredUser | RegistedUser Username AccountNumber deriving Show

printUser :: User -> IO()
printUser UnregisteredUser = 
    putStrLn "Sorry,but we cannt access this account at this time. Please try again or dial 0800 838383"
printUser (RegistedUser (Username a)(AccountNumber b)) = putStrLn $ a ++ " " ++ show b

rUser :: User
rUser = RegistedUser uName aNumber

uName :: Username
uName = Username "pengu"

aNumber :: AccountNumber
aNumber = AccountNumber 7712

-- now onto matchihng some penguins...

data WherePenguinsLive = Antartica | Australia | NewZealand deriving (Eq, Show)

newtype Penguin = Peng WherePenguinsLive deriving (Eq,Show)

equalityPenguin :: WherePenguinsLive -> Bool
equalityPenguin NewZealand = True
equalityPenguin _          = False

isPenguin :: Penguin -> WherePenguinsLive
isPenguin (Peng x) = x

-- now for a more...elaborate example

bluePenguin :: Penguin
bluePenguin = Peng NewZealand
pengu :: Penguin
pengu = Peng Antartica
little :: Penguin
little = Peng Australia

bluePengu :: Penguin -> Bool
bluePengu (Peng NewZealand) = True
bluePengu _                 = False

antarticPengu :: Penguin -> Bool
antarticPengu (Peng Antartica) = True
antarticPengu _                = False

blueOrantartic :: Penguin -> Bool
blueOrantartic x = bluePengu x || antarticPengu x

-- lets match on some tuples...

tupl :: (a,b,c) -> (a,b,c)
tupl (x,y,z) = (x,y,z)

addEmUp2 :: Num a => (a,a) -> a
addEmUp2 (x,y) = fst (x,y) + snd (x,y) 
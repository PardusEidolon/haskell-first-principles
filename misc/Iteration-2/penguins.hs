module Auser where

newtype Username = Username String

newtype AccountNumber = AccountNumber Integer

data WherePenguinsLive = Galapagos | Antarctica | Australia | SouthAfrica | SouthAmerica deriving (Eq, Show)

data Penguin = Peng WherePenguinsLive deriving (Eq,Show)

data User = UnregisteredUser | RegisteredUser Username AccountNumber

printUser :: User -> IO ()
printUser UnregisteredUser = putStrLn "Unregistered User"

printUser (RegisteredUser (Username name)(AccountNumber acctNum)) = putStrLn $ name ++ " " ++ show acctNum

pengu :: WherePenguinsLive -> Bool
pengu Antarctica = True
pengu SouthAfrica = True
pengu _ = False

penguLives :: Penguin -> WherePenguinsLive
penguLives (Peng a) = a

emperor = Peng Antarctica
humboldt = Peng SouthAmerica
macaroni = Peng Antarctica
little = Peng Australia
galapagos = Peng Galapagos

galaPeng :: Penguin -> Bool
galaPeng (Peng Galapagos) = True
galaPeng _                = False

arcoPeng :: Penguin -> Bool
arcoPeng (Peng Antarctica) = True
arcoPeng _                 = False

penguOrGalapagos :: Penguin -> Bool
penguOrGalapagos p = (galaPeng p) || (arcoPeng p)
module SumProductTypes where

import Data.Int
import Data.Char


-- Sum Types
data BigSmall = Big Bool | Small Bool deriving (Eq, Show)
data NumberOrBool = Numba Int8 | BoolyBool Bool deriving (Eq, Show)

-- Product Types
data QuantumBool = QuantumTrue | QuantumFalse | QuantumBoth deriving (Eq, Show,Bounded,Enum)
-- data TwoQs = MkTwoQs QuantumBool QuantumBool deriving (Eq, Show)

-- type alias
type TwoQs = (QuantumBool,QuantumBool)
type Name  = String
type Age   = Int

-- Product Types part #2
data MkPerson = MkPerson Name Age deriving (Eq, Show)

-- product type with a record
data Person = Person { name::String
                     , age::Int } 
                     deriving (Eq, Show)

data Account = Cheque { accountNumber   :: Int
                      , accountName     :: Name
                      , balance         :: Float
                      , avalibleBalance :: Float
                      } deriving (Eq,Show)       
-- sample data

jm :: Person
jm = Person "Julie" 67
ca :: Person
ca = Person "Hank" 54

namae :: Person -> Name
namae (Person n _) = n

howOld :: Person -> Age
howOld (Person _ a) = a

-- sample data #2

account1 :: Account
account1 = Cheque 21754932 "Mr-Flopsy" 120.00 120.00

account2 :: Account
account2 = Cheque 03215195 "Mrs-Flopsy" 500.00 500.00

account3 :: Account
account3 = Cheque 98260618 "Master-Flopsy" 10.00 10.00

isoCodes :: [String]
isoCodes = ["USD", "NZD", "AUD", "GBP", "EUR","RUB"]

accLs :: [Account]
accLs = account1 : account2 : account3 : []

showBal :: Account -> String
showBal (Cheque _ _ _ a) = "Your balance is: " ++ show a

deposit :: Account -> Float ->  IO()
deposit (Cheque _ _ _ a) b = putStrLn $ "You deposited: $" ++ show b ++ "\n" ++ "Your balance is now: $" ++ show (a + b)

withdraw :: Account -> Float ->  IO()
withdraw (Cheque _ s _ a) b = putStrLn $ "You have withdrawn: $" ++ show b ++ "\n" ++ s ++ " " ++ "Your balance is now:"++ " " ++ balance
                            where balance = 
                                    if (a - b) < 0 
                                        then error "Cannot withdraw more than your current balance!"
                                    else "$" ++ show (a - b)

sumBal :: [Account] -> String -> IO()
sumBal acc cur = putStrLn $ "Total sum of account balances are: $" ++ show (foldr ((+) . (\ (Cheque _ _ _ a) -> a)) 0 acc) ++ " " ++ iso
                 where iso
                        | cur == "USD" = cur
                        | cur == "NZD" = cur
                        | cur == "AUD" = cur
                        | cur == "GPB" = cur
                        | cur == "EUR" = cur
                        | cur == "RUB" = cur
                        | otherwise    = error "*Invalid isoCode!*"

sumBal' :: [Account] -> String -> IO()
sumBal' acc cur = putStrLn $ "Total sum of all account balances are: $" ++ show (foldr ((+) . (\ (Cheque _ _ _ a) -> a)) 0 acc) ++ " " ++ isoCode
                 where isoCode = 
                        if (concat . filter (==cur) $ isoCodes) == cur 
                            then cur 
                        else error $ map toUpper "*Invalid isoCodes*"

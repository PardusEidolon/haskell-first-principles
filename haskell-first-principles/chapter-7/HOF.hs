module HigherOrderFuncs where

flips :: (a -> b -> c) -> b -> a -> c
flips f x y = f y x

data Employee = Coder | Manager | Veep | CEO deriving (Eq, Ord, Show)

reportBoss :: Employee -> Employee -> IO()
reportBoss e e' = putStrLn $ show e ++ " is the boss of " ++ show e'

employeeRank :: Employee -> Employee -> IO()
employeeRank e e' = case compare e e' of
    GT -> reportBoss e e'
    EQ -> putStrLn "We all family here"
    LT -> flips reportBoss e e'

codersRule :: Employee -> Employee -> Ordering
codersRule Coder Coder = EQ
codersRule Coder _ = GT
codersRule _ Coder = LT
codersRule e e' = compare e e'

employeeRank2 :: (Employee -> Employee -> Ordering) -> Employee -> Employee -> IO()
employeeRank2 f e e' = case f e e' of
    GT -> reportBoss e e'
    EQ -> putStrLn "We all family here"
    LT -> (flips reportBoss) e e'
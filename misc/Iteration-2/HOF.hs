module HOF where

data Employee = Coder | Manager | Veep | CEO  deriving (Eq, Ord, Show)

reportBoss :: Employee -> Employee -> IO ()
reportBoss e e' = putStrLn $ show e ++ " is the boss of " ++ show e'

-- now for a case expression
employeeRank :: (Employee -> Employee -> Ordering) -> Employee -> Employee -> IO ()
employeeRank f e e' = case f e e' of
    LT -> (flip reportBoss) e e'
    EQ -> putStrLn "nither employee\
                    \ is the boss"
    GT -> reportBoss e e'

-- Coders Rule and CEO's can kiss my ass!
codersRuleCEOsDrool :: Employee -> Employee -> Ordering
codersRuleCEOsDrool Coder Coder = EQ
codersRuleCEOsDrool Coder _ = GT
codersRuleCEOsDrool _ Coder = LT
codersRuleCEOsDrool e e' = compare e e'

dodgy :: Num a => a -> a -> a
dodgy x y = x + y * 10

oneIsOne :: Num a => a -> a
oneIsOne = (flip dodgy) 1

oneIsTwo :: Num a => a
oneIsTwo = oneIsOne 2

thisIsDee :: a -> b -> c -> d -> d
thisIsDee _ _ _ d = d
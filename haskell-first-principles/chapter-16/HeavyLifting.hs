module HeavyLifting where

a :: [Int]
a = fmap (+1) $ read "[1]"

b :: Maybe [String]
b = (fmap . fmap) (++ "lol") (Just ["Hi","Hello"])

c :: Int -> Int
c = (*2) . (\x -> x - 2)

d ::  Integer -> String
d a = (return '1' ++) . show $ intF a -- what it should resolve to "1[0,1,2,3]"

intF :: (Eq a,Enum a,Num a) => a -> [a]
intF 1 = [1]
intF 2 = [2]
intF a = (\x -> [x,1..3]) a

e :: IO Integer
e = let ioi = readIO "1" :: IO Integer
        changed = ("123"++) <$> (fmap show ioi)
        sing = fmap read changed
    in  
        fmap (*3) sing
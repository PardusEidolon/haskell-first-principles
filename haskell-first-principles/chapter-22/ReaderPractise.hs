module ReaderPractise where

import Control.Applicative
import Data.Maybe

x = [1..3]
y = [4..6]
z= [7..9]


xs :: Maybe Integer
xs = lookup 3 $ zip x y
ys :: Maybe Integer
ys = lookup 6 $ zip y z
zs :: Maybe Integer
zs = lookup 4 $ zip x y
z' :: Integer -> Maybe Integer 
z' n = lookup n $ zip x z

-- Now onto the maybe tups

x1 :: Maybe (Integer,Integer)
x1 = fmap (,) xs <*> ys

x2 :: Maybe (Integer,Integer)
x2 = fmap (,) ys <*> zs

x3 :: Integer -> (Maybe Integer, Maybe Integer) 
x3 = liftA2 (,) z' z'

-- helper funcs

summed :: Num a => (a,a) -> a
summed = uncurry (+)

-- let's bolt it

bolt :: Integer -> Bool
bolt = liftA2 (&&) (<3) (<8)

-- colbbled main function

main :: IO ()
main = do
    -- print $
    --     traverse Just . reverse $ x
    -- print $ sequenceA [x,y]
    -- print $ sequenceA [xs,ys]
    -- print $ fmap summed $ fmap (,) xs <*> ys
    -- print $ bolt 7
    -- print $ bolt <$> z
    -- print $ sequenceA [(<3),(<8), even] 7
    print $ foldr (&&) True (fmap bolt x)
    print $ (sequA . fromMaybe 0  $ s')
    print $ fmap bolt ys

-- traversin and sequencing
sequA :: Integral a => a -> [Bool]
sequA = sequenceA [(<3), (<8), even]

s' :: Maybe Integer
s' = fmap summed $ fmap (,) xs <*> ys
module Main where

import Data.Monoid
import Control.Applicative
import Test.QuickCheck 
import Test.QuickCheck.Checkers 
import Test.QuickCheck.Classes
import BadMonoid
import Exrcises
import Apl1
import qualified FinalExr as E


type SSI = (String,String,Int)
type SSS = (String,String,(Sum Int))
type SI = (String,Int)


trigger :: [SSI]
trigger = undefined

-- zlist :: ZipList (Sum Int)
-- zlist = ZipList [Sum 1]

maybs :: Maybe SSS
maybs = undefined

listy :: List SSI
listy = undefined

-- The Yays
mYay :: Yay String
mYay = undefined

sYay :: (Yay String,Int)
sYay = undefined

fYay :: Yay SSI
fYay = undefined

aYay :: Yay SSI
aYay = undefined
-- 


-- The wrapped Yays
mWrapped :: Wrapped String 
mWrapped = undefined

sWrapped :: (Wrapped String, Int)
sWrapped = undefined

fWrapped :: Wrapped SSI
fWrapped = undefined

aWrapped :: Wrapped SSI
aWrapped = undefined
-- 

-- List
fList :: List SSI
fList = undefined

aList :: List SSI
aList = undefined
-- 

-- Wrapped ZipList'
fZlist :: ZipList' SSI
fZlist = undefined

aZlist :: ZipList' SSI
aZlist = undefined
-- 

-- Verification
-- fValid :: Validation SSI
-- fValid = undefined

-- aValid :: Validation SSI
-- aValid = undefined
-- 

main :: IO ()
main = do
-- The Good batch
    quickBatch $ monoid mYay
    quickBatch $ semigroup sYay
    quickBatch $ functor fYay
    quickBatch $ applicative aYay

    quickBatch $ monoid mWrapped
    quickBatch $ semigroup sWrapped
    quickBatch $ functor fWrapped
    quickBatch $ applicative aWrapped

    quickBatch $ functor fList
    quickBatch $ applicative aList

    quickBatch $ functor fZlist
    quickBatch $ applicative aZlist

    E.main
    -- quickBatch $ functor fValid
    -- quickBatch $ applicative aValid
-- The Bad batch 
    -- quickBatch $ monoid maybs
    -- quickBatch $ applicative maybs
    -- quickBatch $ applicative listy
    -- quickBatch $ monoid Twoo
    -- quickBatch $ applicative trigger
    -- quickBatch $ monoid zlist
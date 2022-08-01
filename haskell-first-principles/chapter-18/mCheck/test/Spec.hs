module Main where

import Data.Monoid 
import Control.Applicative
import Test.QuickCheck
import Test.QuickCheck.Checkers 
import Test.QuickCheck.Classes
import BadMonad
import GoodMonad
import Data.Monoid
import Lib

type BPS = ([Bool],Product Float,Sum Int)
type BS = ([Bool],Sum Int)

meMe :: [BPS]
meMe = undefined

badMonad :: CountMe BPS
badMonad = undefined

goodMonad :: CountMe' BPS
goodMonad = undefined

goodMonad' :: CountMe' String
goodMonad' = undefined

goodMonad'' :: (CountMe' String,Int)
goodMonad'' = undefined


main :: IO ()
main = do
    -- quickBatch (monad meMe)
    quickBatch (monad badMonad)
    quickBatch (monad goodMonad)
    quickBatch (applicative goodMonad)
    quickBatch (functor goodMonad)
    quickBatch (monoid goodMonad')
    quickBatch (semigroup goodMonad'')



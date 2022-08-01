module Main where

import Test.QuickCheck
import Test.QuickCheck.Checkers 
import Test.QuickCheck.Classes
import Test.Hspec
import Data.Monoid
import Lib

type BPS = ([Bool],Product Float,Sum Int)
type SSF = (String,Sum Int,Float)

-- 1.
fNope :: Nope BPS
fNope = undefined
aNope :: Nope BPS
aNope = undefined
mNope :: Nope BPS
mNope = undefined
-- 
-- 2.
-- 
fPhhhbbttt :: PhhhbbtttEither SSF BPS
fPhhhbbttt = undefined
aPhhhbbttt :: PhhhbbtttEither SSF BPS
aPhhhbbttt = undefined
mPhhhbbttt :: PhhhbbtttEither SSF BPS
mPhhhbbttt = undefined
-- 
-- 3.
-- 
fIdentity :: Identity BPS
fIdentity = undefined
aIdentity :: Identity BPS
aIdentity = undefined
mIdentity :: Identity BPS
mIdentity = undefined
-- 
-- 4.
-- 
fList :: List BPS
fList = undefined
aList :: List BPS
aList = undefined
mList :: List BPS
mList = undefined

main :: IO ()
main = hspec $ do
    describe "Nothing but Nope" $ do
        it "Nope Functor" $ do
            property $ quickBatch (functor fNope)
        it "Nope Applicative" $ do
            property $ quickBatch (applicative aNope)
        it "Nope Monad" $ do
            property $ quickBatch (monad mNope)
    describe "PhhhbbtttEither" $ do
        it "PhhhbbtttEither Functor" $ do
            property $ quickBatch (functor fPhhhbbttt) 
        it "PhhhbbtttEither Applicative" $ do
            property $ quickBatch (applicative aPhhhbbttt)
        it "PhhhbbtttEither Monad" $ do
            property $ quickBatch (monad mPhhhbbttt)
    describe "Identity Crisis" $ do
        it "Identity Functor" $ do
            property $ quickBatch (functor fIdentity)
        it "Identity Applicative" $ do
            property $ quickBatch (applicative aIdentity)
        it "Identity Monad" $ do
            property $ quickBatch (monad mIdentity)
    describe  "Verbosed List" $ do
        it "List Functor" $ do
            property $ quickBatch (functor fList)
        it "List Applicative" $ do
            property $ quickBatch (applicative aList)
        it "List Monad" $ do
            property $ quickBatch (monad mList)
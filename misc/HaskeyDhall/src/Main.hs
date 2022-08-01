{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Functor.Identity
import Dhall

data Person = Person {name :: Text, age :: Natural, admin :: Bool} deriving (Generic, Show, FromDhall)

data Foobar = Foobar {foo :: Bool, bar :: Natural, baz :: Double} deriving (Generic, Show, FromDhall)
-- records must be the same with the correspont inputs as they are in a dhall file
data Foobarz = Foobarz {foos :: Bool, bazy :: Text} deriving (Generic, Show, FromDhall,ToDhall)

data Example = Example {one :: Bool, two :: Bool} deriving (Generic, Show, ToDhall)

instance FromDhall a => FromDhall (Identity a)

main :: IO ()
main = do
    x <- input auto "./data/config.dhall" -- import file with a record, the record in this file must match the one in here for it to return
    p <- input auto "./data/person.dhall" -- with the input auto we let the compiler come up with the types we declare below
    i <- detailed (input auto "./data/identity.dhall")
    f <- input auto "\\(r : { one : Bool , two : Bool }) -> r.one || r.two" -- you can declare functions directly in the block here
    -- s <- input auto "(./data/makeBools.dhall) True"
    -- b <- input auto "True" :: IO Bool
    getFoo <- input auto "./data/getFoo.dhall" -- you can use files as functions
    -- let
    --     path = "./data/boolean.dhall"
    -- print (x :: Person)
    print (x :: Foobar)
    print (p :: Person)
    print (i :: Identity Double)
    print (f (Example {one = True, two = False }) :: Bool)
    -- print (s :: Vector Bool)
    print (getFoo (Foobarz {foos = True , bazy = "welcome"}) :: Bool)
    -- writeFile path (show b)

-- Vector is equivilent to []ish

-- fileTest :: IO ()
-- fileTest = do
--     p <- input auto "./data/person.dhall"
--     let
--         path = "./data/file.dhall"
--         value = p :: Person
--     writeFile path (show value)
--     print value


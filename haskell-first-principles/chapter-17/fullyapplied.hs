{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
module FullyApplied where

newtype Blah = Blah String deriving (Show,Eq,Ord,Semigroup,Monoid)

-- however because blah is a fully applied type we cannont make a functor or applicative type out of this 
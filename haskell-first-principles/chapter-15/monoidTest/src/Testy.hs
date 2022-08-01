module Testy where

import Test.QuickCheck
import Data.Monoid
import Control.Monad

data Bull = Fools | Twoo deriving (Eq, Show)


instance Arbitrary Bull where 
    arbitrary = 
        frequency [ (1, return Fools) , 
                    (1, return Twoo)]

instance Semigroup Bull where
    (<>) Fools Fools = Fools
    (<>) Twoo   _    = Twoo
    (<>) _     Twoo  = Twoo

-- instanceing the laws of identity make sure that the identity of something returns the other value

instance Monoid Bull where
    mempty      = Fools
    mappend     = (<>)

type BullMappend  = Bull -> Bull -> Bull -> Bool
type Intend       = Int -> Int -> Int -> Bool
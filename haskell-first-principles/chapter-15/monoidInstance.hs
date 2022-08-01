module MonoidInstance where

import Data.Monoid

data Optional a = 
      Nada
    | Only a
    deriving (Eq,Show)

instance Semigroup a => Semigroup (Optional a) where
   (<>) (Only a) (Only b) = Only $ (<>) a b
   (<>) (Only a) Nada = Only a
   (<>) Nada (Only b) = Only b
   (<>) Nada Nada  = Nada

instance Monoid a => Monoid (Optional a) where
    mempty = Nada
    mappend = (<>)
 

m :: Maybe String -> Maybe String -> Maybe String
m (Just a) (Just b) = Just (a <> b)
m (Just a) _ = Just a
m _ (Just b) = Just b
m Nothing Nothing = Nothing

-- respect the laws of the agebra
-- good programs result in predictable outcomes
-- Binary: Meaning 2, typically 2 arguments
-- Associative: either to the left or the right, this must be satisfied
-- Operation: we can just read this as "function" that takes 2 arguments
-- Identity: some value that when combined with any other value will return the other value
-- the identity of addition for example is 0 be cause 1 + 0 or 4 + 0 will always return 4, for multiplication its 1 becuase 1 * 6 is 6 
-- communitive that way but not all monad instances are.

-- there often multiple instances of the same type, that datatype have different types of valid monoids.
-- examples such as sum and product any and all
-- instances that are all valid monoids to achieve monoidic results
-- by following the laws of algebra
module TraverseIt where

import Data.Maybe
import Control.Monad

-- traverse :: (Traversable t, Applicative f) => (a -> f b) -> t a -> f (t b)

mls :: [Maybe Char]
mls = map Just "I like yellow cars"

mls2 :: Maybe [Maybe Char]
mls2 = Just . map Just $ "I like red cars"

tls :: Maybe [Char]
tls = traverse id mls

tls2 :: Maybe String
tls2 = traverse id . fmap join . sequence $ mls2


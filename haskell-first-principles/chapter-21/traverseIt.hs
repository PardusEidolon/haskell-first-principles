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

-- (<=<) :: Monad m => (b -> m c) -> (a -> m b) -> a -> m c

func1 :: String -> IO String
func1 x = putStrLn x >> getLine

func2 :: String -> IO ()
func2 = putStrLn

-- func3 :: String -> IO ()
-- func3 x = (<=<) func2 func1 x

func3R :: String -> IO ()
func3R x = func1 >=> func2 $ x

func3L :: String -> IO ()
func3L x = func2 <=< func1 $ x
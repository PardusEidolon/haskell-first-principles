module FixerUpper where

foo :: Maybe String
foo = (fmap const (Just "Hello")) <*> pure "World"

baz :: Maybe (Integer, Integer, [Char], [Integer])
baz = ((,,,) <$> Just 90 <*> Just 10 <*> Just "Tierness") <*> pure [1,2,3]
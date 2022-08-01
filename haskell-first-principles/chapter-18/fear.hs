module Fear where

-- “I must not fear. Fear is the mind-killer. 
-- Fear is the little-death that brings total obliteration. 
-- I will face my fear. I will permit it to pass over me and through me. 
-- And when it has gone past I will turn the inner eye to see its path. 
-- Where the fear has gone there will be nothing. Only I will remain.”

import Control.Monad (join)

-- keep in mind this is (>>=) flipped 
bind :: Monad m => (a -> m b) -> m a -> m b
bind f m = join . fmap f $ m

addOne :: Num a => a -> [a]
addOne x = [x,1]

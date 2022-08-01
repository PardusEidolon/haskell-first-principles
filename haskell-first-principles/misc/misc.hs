module Misc where

import Data.Maybe
import GHC.IO.Exception (IOErrorType(NoSuchThing))

elimDupes [] acc = acc                          -- empty
elimDupes (x:xs) acc                    
        | elem x acc = elimDupes xs acc         -- head in acc
        | otherwise = elimDupes xs (acc ++ [x]) -- head not in acc
compress l = elimDupes l []

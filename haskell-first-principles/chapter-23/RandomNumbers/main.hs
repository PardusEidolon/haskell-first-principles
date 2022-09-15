module Main where

import Control.Applicative (liftA3)
import Control.Monad (replicateM)
import Control.Monad.Trans.State.Lazy
import System.Random

data Die = DieI | DieII | DieIII | DieIV | DieV | DieVI deriving (Show,Eq)

main :: IO ()
main = print "hi"

int2Die :: Int -> Die
int2Die x
    | x == 1 = DieI
    | x == 2 = DieII
    | x == 3 = DieIII
    | x == 4 = DieIV
    | x == 5 = DieV
    | x == 6 = DieVI
    | otherwise = faultE
        where
            faultE = error $ "got " ++ (show x) ++ ": Use an integer from 1-6!"

maybeDie :: Int -> Maybe Die
maybeDie n =
    case n of
        1 -> Just DieI
        2 -> Just DieII
        3 -> Just DieIII
        4 -> Just DieIV
        5 -> Just DieV
        6 -> Just DieVI
        n -> Nothing

randomRoll3 :: (Die, Die, Die)
randomRoll3 = do
    let
        s = mkStdGen 0
        (d1, s1) = randomR (1, 6) s
        (d2, s2) = randomR (1, 6) s1
        (d3, _) = randomR (1, 6) s2
    (int2Die d1, int2Die d2, int2Die d3)

-- Time to rev it up!!

rollDie :: State StdGen (Maybe Die)
--              StdGen is our argument to our function randomR we need this for state computation
--                      Maybe Die is our State result 
rollDie = state $ do
    (n,s) <- randomR (1,6) -- in spirit this should be our agument if we werent using state: (mkStdGen 0)
    return (maybeDie n, s)

netherDie :: Int -> State StdGen [Maybe Die]
netherDie x = replicateM x rollDie

rickRoll :: Int -> Maybe Die
rickRoll x = evalState rollDie (mkStdGen x)

-- below is me testing with state

stateString :: String -> (Int,String)
stateString x = (0, "Hello " ++ x ++ "!")

stringState :: State String Int
stringState = state stateString

fmapState :: State StdGen Die
fmapState = fmap int2Die (state (randomR (1,6)))

-- evalState fmapState (mkStdGen 0)
-- so why this if tuples are evaluated by their second arg?

-- randomR is awaiting application of type 'StdGen' this satisfies the state function which takes a partial application as an argument
-- as a side note both functions are waiting for 1 arguments
-- the behaviour is similar to 'f = fmap (+) (*2) <*> (+10)'
-- (state (randomR (1,6))) :: StdGen -> State StdGen Die

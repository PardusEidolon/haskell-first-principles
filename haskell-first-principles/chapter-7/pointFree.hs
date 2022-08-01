module PointFree where

-- Point-Free Version
foo = length . filter (=='a')

-- The Explicit Parametized Parenthesized Version
foo' x = (length . filter (=='a')) x

-- Fully applied function version
bar = foo' "aaaids"

-- Arith2
add :: Int -> Int -> Int
add x y = x + y

addPF :: Int -> Int -> Int
addPF = (+)

addOne :: Int -> Int
addOne = \x -> x + 1

addOnePF :: Int -> Int
addOnePF = (+1)

main :: IO ()
main = do
    print (0 :: Int)
    print (add 1 0)
    print (addOne 0)
    print (addOnePF 0)
    print ((addOne . addOne) 0)
    print ((addOnePF . addOne) 0)
    print ((addOne . addOnePF) 0)
    print ((addOnePF . addOnePF) 0)
    print (negate (addOne 0))
    print ((negate . addOne) 0)
    print ((addOne . addOne . addOne . negate . addOne) 0)

-- demonstrating composition

-- the explicit version
printn :: Show a => a -> IO()
printn a = (putStrLn . show) a

-- point free version
printn' :: Show a => a -> IO()
printn' = putStrLn . show

-- when composing functions, think of them as just one whole function rather thhan seperate ones. when applied to a value evaluate backwards.

module Exrc.Either where

lefts' :: [Either a b] -> [a]
lefts' ls = foldr f [] ls
    where
        f x xs = case x of
            Left  x -> (x:xs)
            Right _ -> xs

rights' :: [Either a b] -> [b]
rights' ls = foldr f [] ls
    where
        f x xs = case x of
            Right x -> (x:xs)
            Left  _ -> xs

partitionEithers' :: [Either a b] -> ([a], [b])
partitionEithers' ls = foldr f ([],[]) ls
    where
        f x (as,bs) =
            case x of
                Left  a -> ((a:as), bs)
                Right b -> (as, (b:bs))

either' :: (a -> c) -> (b -> c) -> Either a b -> c
either' f g e = case e of
    Left a  -> f a
    Right b -> g b

eitherMaybe'' :: (b -> c) -> Either a b -> Maybe c
eitherMaybe'' f = either' (const Nothing) (Just . f)
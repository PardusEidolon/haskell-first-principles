module LetsZipIt where

zippin :: [a] -> [b] -> [(a,b)]
zippin _ [] = []
zippin [] _ = []
zippin (x:xs) (y:ys) = (x,y): zippin xs ys

zippinf :: (a -> b -> c) -> [a] -> [b] -> [c]
zippinf _ [] _ = []
zippinf _ _ [] = []
zippinf f (x:xs) (y:ys) = f x y: zippinf f xs ys
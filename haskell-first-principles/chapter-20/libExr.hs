module LibExr where

myLength :: Foldable t => t a -> Int
myLength xs = foldl (\c _ -> c + 1) 0 xs

mySum :: (Foldable t , Num a ) => t a -> a
mySum x = foldr (+) 0 x

myProduct :: (Foldable t , Num a) => t a -> a
myProduct x = foldl (*) 1 x

myElem :: (Foldable t, Eq a) => a -> t a -> Bool
myElem x xs = (any . (==)) x xs

myElem' :: (Foldable t, Eq a) => a -> t a -> Bool
myElem' element list = foldr (\a b -> b || a == element ) False list

myMin :: (Foldable t, Ord a) => t a -> Maybe a
myMin ls = foldr f Nothing ls
    where
        f a Nothing  = Just a
        f a (Just b) = Just (min a b) 

myMax :: (Foldable t, Ord a) => t a -> Maybe a
myMax ls = foldr go Nothing ls
    where
        go a Nothing  = Just a
        go a (Just b) = Just (max a b) 

myNull :: (Foldable t) => t a ->Bool
myNull ls = foldr go True ls
    where
        go a b = False

myFold :: (Foldable t, Monoid m) => t m -> m
myFold ls = foldMap id ls

myFoldMap :: (Foldable t, Monoid m) => (a -> m) -> t a -> m
myFoldMap f ls = foldr (mappend . f) mempty ls
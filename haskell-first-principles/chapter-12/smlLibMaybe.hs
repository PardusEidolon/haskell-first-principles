module SmallMaybeLib where

isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust Nothing  = False

isNothing :: Maybe a -> Bool
isNothing Nothing  = True
isNothing (Just _) = False

-- maybe catamorph systems
mayybee :: b -> (a -> b) -> Maybe a -> b
mayybee b _ Nothing  = b
mayybee _ f (Just a) = f a

fromMaybe :: a -> Maybe a -> a
fromMaybe a Nothing  = a
fromMaybe _ (Just a) = a

listToMaybe :: [a] -> Maybe a
listToMaybe []     = Nothing
listToMaybe (x:xs) = Just x

maybeToList :: Maybe a -> [a]
maybeToList Nothing  = []
maybeToList (Just a) = [a]

-- list maybes
catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes (x:xs) = case x of
    Just x -> x : catMaybes xs
    Nothing -> catMaybes xs

flipMaybe :: [Maybe a] -> Maybe [a]
flipMaybe a = foldr f (Just []) a 
    where f Nothing _ = Nothing 
          f _ Nothing = Nothing
          f (Just a) (Just as) = Just (a:as)
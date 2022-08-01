# List Ordered - Breakdown

```haskell
-- only here for reference
listOrdered :: (Ord a) => [a] ->Bool 
listOrdered xs = 
    snd $ foldr go (Nothing, True) xs 
        where go _ status@(_, False) = status 
              go y (Nothing, t) = (Just y, t) 
              go y (Just x, t) = (Just y, x >= y)
```

```haskell
-- intital function call
*Tests Tests2> listOrdered "412"

listOrdered xs =
    -- first computation
    snd $ foldr go (Nothing, True) "421" 
        where go _ status@(_, False) = status 
              go '1' (Nothing, True) = (Just '1', True) 
              go y (Just x, t) = (Just y, x >= y)
    -- second computation
    go (Just '1', True) "4"
                go '2' (Just '1', True) = (Just '2', '1' >= '2')
    -- third computation
    go (Just '2', False) "4" -- This hits our base case, so result in status

    > (Just '2', False) -- go gives us the result
    > snd $ (Just '2', False) -- we apply snd to take Bool from the tuple (Maybe a, Bool)
    > False -- it then returns the value of the boolean that was returned
 
```
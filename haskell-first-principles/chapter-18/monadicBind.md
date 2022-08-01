# Binding and joining with monads

```haskell
meh :: Monad m => [a] -> (a -> m b) -> m [b]
meh [] _ =  return []
meh (x:xs) f = f x >>= \a -> (meh xs f) >>= \b -> return $ a : b

foo x = Just x

meh [1] foo
meh (1:[]) foo = foo 1 >>= \a -> (meh [] foo) >>= \b -> return $ 1 : []
-- a is bound to 1 and b is bound to an empty list
```

```haskell
flipType :: Monad m => [m a] -> m [a]
flipType m = meh m id

id :: a -> a

meh [Just 1] id
meh (Just 1:[]) id = id (Just 1) >>= \a -> (meh [] id) >>= \b -> return $ 1 : []
-- again \a is bound to 1 and \b is bound to an empty list
-- were just reconstructing the list by binding things out of the list and stictching it back with the intial strucure inside the list
```

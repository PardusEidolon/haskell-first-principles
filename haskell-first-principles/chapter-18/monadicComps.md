# Composing with Monads

```haskell
(>=>)::Monad m => (a -> m b) -> (b -> m c) -> a -> m c

sayHi :: String -> IOString
readM :: Read a => String ->IO a
getAge :: String -> IOInt
askForAge :: IOInt
```

```haskell
kalisi :: (String -> IO String) -> (String -> IO Int) -> String -> IO Int
--          sayHi ^                 readM ^
kalisi = sayHi >=> readM
```


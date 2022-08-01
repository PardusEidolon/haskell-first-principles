# Type Methods

1. [ ]

```haskell
pure :: a -> [] a
(<*>) [] (a -> b) -> [] a -=> [] b
-- or
pure :: a -> [a]
(<*>) [(a -> b)] -> [a] -=> [b]
-- or
pure :: Folable t => a -> t a
(<*>) Folable t => (a -> b) -> t a -> t b
```

2. IO

```haskell
pure :: a -> IO a 
(<*>) :: IO (a -> b) -> IO a -> IO b
```

3. ( , ) a

```haskell
pure :: a -> (l , a) 
(<*>) :: (l, (a -> b)) -> (l , a) -> (l, b)
```

4. (->) e

```haskell
pure :: a -> e a 
(<*>) :: (e -> (a -> b)) -> (e -> a) -> (e -> b)
```
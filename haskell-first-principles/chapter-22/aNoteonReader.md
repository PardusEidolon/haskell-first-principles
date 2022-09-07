# A Note on reader

Heres my thoughts on the reader monad instance...

```haskell
instance Monad (Reader ra) where
    return = pure
    (Reader rab) >>= ram = Reader $ \r -> runReader (ram (rab r)) r
```

From what I can tell `Reader` is a function and await application. So lets break open this can of worms with a concrete example, then look at the types.

```haskell
newtype Reader r a = Reader {runReader :: r -> a}

Reader words >>= return = Reader $ \r -> runReader (return (words r)) r
--                          [5]    [1]    [4]        [3]     [2] [1] [1]
```

1. This is just a funtion that inherits it's type depending on whats being applied. *remeber `Reader` must take a funtion as an argument.*
2. Words is a function that is awaiting application from our anonymous `r` function.
3. In order for runReader to work we need to return `Reader` which is what were doing with our return function after application and the value `r` outside of the paranthesis.
4. Were unwrapping the function in the body of the anonymous function and awaiting application.
5. We return with the anonymous function with the given monadic strcucture `Reader`. Again it's a function of functions awaiting application the return output must be a partially applied function in this context.
6. If the type of a typical monad is *m a -> (a -> mb) -> m b* then the type for `Reader` would be *(m -> b) -> (a -> m -> b) -> (m -> b)*
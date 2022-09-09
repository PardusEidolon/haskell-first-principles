# A note on ReaderT

Heres my thoughts on the readerT...

```haskell
ReaderT :: (r -> m a) -> ReaderT r m a
-- [1]
runReaderT :: ReaderT r m a -> r -> m a

withReaderT :: (r' -> r) -> ReaderT r m a -> ReaderT r' m a
withReaderT f m = ReaderT $ runReaderT m . f
-- [2]

ask :: Monad m => ReaderT r m r
```

1. Or simply put reader must take a function that returns a monad
2. `(r' -> r) -> ReaderT r m a` look almost like `(r -> m a) -> ReaderT r m a`

### Side Note
So is the middle type argument to `ReaderT` give structure to the output, which is to the right?
we also want to preserve structure so with the type `r' -> r` were transforming the type or value if `r`.

what happens if...

```haskell
app :: ReaderT Connection ScottyM ()
rConn :: Connection -- techinally IO Connection but were binding that out for simple sake.
(runReaderT app rConn) :: ScottyM ()
```

```haskell
:t runReaderT :: ReaderT r m a -> r -> m a
:t runReaderT app :: r -> m a
:t runReaderT app rConn :: m a
```
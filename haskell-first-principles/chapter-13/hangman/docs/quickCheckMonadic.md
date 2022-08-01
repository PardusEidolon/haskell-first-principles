# QuickCheck Monadic

```haskell
prop_randomWords :: Property
prop_randomWords =
  monadicIO $ do
    a <- run H.randomWord'
    b <- run H.randomWord'
    assert (a /= b)

-- ===

monadicIO :: Testable a => PropertyM IO () -> Property
run :: Monad m => IO String -> PropertyM IO
assert :: Monad m => Bool -> PropertyM IO ()
H.randomWord' :: IO String
```
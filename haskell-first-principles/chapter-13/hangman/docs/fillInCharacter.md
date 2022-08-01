# Fill-In Character Breakdown

```haskell
pzl = Puzzle "hi" [Nothing,Nothing] []

fillInCharacter (Puzzle "hi" [Nothing,Nothing] []) 'h' =
        Puzzle "hi" newFilledInSoFar ('h':[])
            where zipper 'h' 'h' [Nothing,Nothing] =
                if 'h' == 'h'
                    then Just 'h'
                    else [Nothing,Nothing]
              newFilledInSoFar =
                  zipWith (zipper 'h') "hi" [Nothing,Nothing]
-- zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]

> Puzzle "hi" [Nothing,Just 'i'] "h"
```
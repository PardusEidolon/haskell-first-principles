module Bottommadness where

foo :: [Int]
foo = [x^y | x <- [1..5], y <- [2,undefined]]

-- Will it cry the tears in an ednless bottom recursion or will it make a value sandwhich?

-- 1. bottom ☑
-- 2. value ☑
-- 3. bottom ☑
-- 4. value ☑
-- 5. bottom ☑
-- 6. value ☑
-- 7. bottom ☑
-- 8. value ☑
-- 9. value ☑
-- 10. bottom ☑

-- is this normal form or weakhead normal form or both or neither?

-- remember: normal form is something that has been fully evauluated and weakhead-normal-form is something only partially evaluated 
-- or as far as it takes to reach a data constructor. normal form is also weakhead normal form but weakhead normal form is not normal form.

-- 1. NF & WHNF ☑
-- 2. WHNF ☑
-- 3. Neither ☑
-- 4. WHNF ❌ : correct answer is neither
-- 5. Niether ☑
-- 6. Niether ☑
-- 7. WHNF ☑
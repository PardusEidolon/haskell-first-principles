module Bottom where

-- when we say something is bottom it means that it doesn't evaluate to a sucessfully or result in a value.

f :: Bool -> Int
f False = error "yayahahah"
f True = 1

-- an exception will be thrown if we pass true when calling the argument in the the prelude.
f' :: Bool -> Int
f' False = 0

-- creating a total function can be achieved with the maybe datatype, Maybe a takes an argument of the type a and a value of nothing so depending on what your matching
-- on it can renturn the value that you want or a value of nothing

maybs :: (Num a,Fractional a) => Bool -> Maybe a
maybs True  = Just 1.0
maybs _      = Nothing

foo :: Bool -> Int
foo False = 0
foo _ = error $ "*** Exception: "
            ++ "Non-exhaustive"
            ++ "patterns in function f"
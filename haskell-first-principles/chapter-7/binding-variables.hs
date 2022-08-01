module BindingVariables where

-- this function is lexically scoped as you can the see x is bound in the expression. so it doen't matter what we put in as the parameter as
-- as long as it matches the type signature. The GHC will always take the inner most binding as precidence by the way Jack just so you know ;)

bindExp :: Num a => a -> String
bindExp x = 
    let x = 10; y = 5 in
    "x was " ++ show x ++
    " and y is " ++ show y

-- this however will not work. This is actually the oppisite of lexcailly sccoped. as a matter of fact the argument z is broken because the main function doesnt
-- know what y is as it's defined in the expression z but z is looking futher up the function and has no idea what y is. What im saying is y is not a fnction but an 
-- argument to the argument of z.

-- brokenFunc :: Integer -> String
-- brokenFunc x = <- z thinks y is up here
--     let z = y + x in
--         let y = 5 in <- not down here :)
--         "the integer was: "
--         ++ show x ++ " and y was: "
--         ++ show y ++ " and z was: "
--         ++ show z
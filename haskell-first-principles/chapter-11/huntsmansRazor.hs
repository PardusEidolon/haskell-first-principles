module HRazor where

data Expr = Lit Integer | Add Expr Expr deriving Show


a1 :: Expr
a1 = Add (Add (Add (Lit 12) (Lit 12)) (Lit 1)) (Lit 10)

a2:: Expr
a2 = Add a1 (Lit 20001)

a3 :: Expr
a3 = Add (Add (Lit 2) (Lit 3)) (Lit 20)

eval :: Expr -> Integer
eval (Lit n) = n
eval (Add a b) = (eval a) + (eval b)

ePrinter :: Expr -> String
ePrinter (Lit n)   = show n
ePrinter (Add a b) = ePrinter a ++ " + " ++ ePrinter b
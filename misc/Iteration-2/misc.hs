module Misc where

bees :: String -> Bool
bees "wez" = True
bees "wes" = True
bees "wed" = True
bees _ = False

newtype User = User String
newtype Rego = Rego Integer

data Account = InvalidUser | ValidUser User Rego

myUsername :: User
myUsername = User "Karen"

myRego :: Rego
myRego = Rego 1142

validator :: Account
validator = ValidUser myUsername myRego

printer :: Account -> IO()
printer InvalidUser = putStrLn "wut?"
printer (ValidUser (User a) (Rego b)) = putStrLn $ a ++ " " ++ show b

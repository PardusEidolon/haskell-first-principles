module Cool where

greetifCool :: String -> IO ()
greetifCool coolness =
    if password
        then putStrLn "Yeh your cool. *sniff*"
    else
        putStrLn "Burn him! Heratic!! Kill the demon!"
    where password = coolness == "sweetjonson69"

coolFunction :: String -> IO ()
coolFunction coolness =
    if cool coolness
        then 
            putStrLn "Sup lil bitch"
    else 
        putStrLn "your going to regret you said that"
    where cool v = v == "eat my ass"
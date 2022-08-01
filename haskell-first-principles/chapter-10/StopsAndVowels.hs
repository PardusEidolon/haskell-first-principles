module StopsAndVowels where
import Data.Foldable (Foldable)

stops :: String
stops = "pbtdkg"

vowels :: String
vowels = "aeiou"

nouns:: [String]
nouns = ["people","art","world","health","thanks","year","music","data","system","computer"]

verbs::[String]
verbs = ["accept","adore","build","buy","Carry","compete","Dance","describe","Hang","looks" ]

f :: [String]
f = [[s1,xs,s2] | s1 <- stops, xs <- vowels, s2 <- stops]

f' :: [String]
f' = [['p',xs,s2] | xs <- vowels, s2 <- stops]

sentences :: [String]
sentences = [n1 ++ " " ++ v0 ++ " " ++ n2 | n1 <- nouns, v0 <- verbs, n2 <- nouns ]

-- what does this function do?

seekritFunc :: String -> Int
seekritFunc x = div (sum . map length . words $ x) (length . words $ x)

preciseFunc :: String -> Float
preciseFunc xs = w1 / w2
            where w1 = fromIntegral . sum . map length . words $ xs
                  w2 = fromIntegral . length . words $ xs

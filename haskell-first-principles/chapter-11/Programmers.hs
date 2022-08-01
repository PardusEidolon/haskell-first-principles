module Programmers where
-- some more record types:
data OperatingSystem = 
                      Linux 
                    | OpenBSD
                    | Mac 
                    | Windows 
                    deriving (Eq, Show)
data ProgLang = 
                Haskell
                | Agda
                | Idris
                | PureScript
                deriving (Eq, Show)

data Programmer = Programmer { os :: OperatingSystem
                             , lang :: ProgLang}
                    deriving (Show, Eq)

--  generate all possible values of type programmer

allOperatingSystems :: [OperatingSystem]
allOperatingSystems = [Linux,OpenBSD,Mac,Windows]

allLanguages :: [ProgLang]
allLanguages = [Haskell,Agda,Idris,PureScript]

allProgrammers :: [Programmer]
allProgrammers = [Programmer os lang | os <-allOperatingSystems, lang <- allLanguages]

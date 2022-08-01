module Planets where

data Planets = EARTH | MARS | JUPITER  deriving (Eq, Ord, Show)
data PlanetItem = PlanetNum Integer | PlanetName Planets deriving (Eq, Ord, Show)

planetIf :: PlanetItem -> String
planetIf x = if x `elem` [PlanetName EARTH,PlanetName MARS,PlanetName JUPITER]
                then  "congrats, your a planet"
                else "pluto is not a planet."

planetEQ :: Planets -> IO ()
planetEQ p
    | p == EARTH = putStrLn "hello there you handsome blue marble"
    | otherwise = putStrLn "Nope"

planetLs :: [PlanetItem]
planetLs = [PlanetName EARTH,
            PlanetName MARS,
            PlanetName JUPITER]

planetFilt :: [PlanetItem] -> [Planets]
planetFilt p = [x | PlanetName x <- p ]

greaterPlanet :: [PlanetItem] -> Planets
greaterPlanet p = foldr max (head times) times
            where times = planetFilt p
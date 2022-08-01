module InstanceExr where
import Data.Monoid
data YeahNah = Yeh | Nah deriving (Eq,Show)

newtype Slang = Slang {getYeaNahs :: YeahNah} deriving Show
 
instance Semigroup Slang where
    (<>) (Slang Yeh) (Slang Yeh) = (Slang Nah)
    (<>) (Slang Yeh) _ = (Slang Yeh)
    (<>) _ (Slang Yeh) = (Slang Nah)
    (<>) (Slang Nah) (Slang Nah) = (Slang Yeh)

instance Monoid Slang where
    mempty = Slang Nah
    mappend = (<>)

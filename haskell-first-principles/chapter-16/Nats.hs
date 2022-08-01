{-# LANGUAGE RankNTypes #-}
module Nats where
-- natural formations, the oppisite of a functor. Transforming the strucuture but preserving the value

type Nat f g = forall a . f a -> g a 

type Nat' f g a = f a -> g a

maybeToList :: Nat Maybe [] 
maybeToList Nothing =[] 
maybeToList (Just a) = [a]

-- below is not allowed
-- degenerateMtl ::Nat Maybe [] 
-- degenerateMtl Nothing =[] 
-- degenerateMtl (Just a) = [a+1]

degenerateMtl :: Num a => Nat' Maybe [] a 
degenerateMtl Nothing =[] 
degenerateMtl (Just a) = [a+1]
# Traversable Big



```haskell
instance Traversable (Big a) where
--   traverse f (Big a b b') = fmap (Big a) (f b) <*> (f b')
  traverse id (Big a b b') = fmap (Big a) (id b) <*> (id b')

traverse :: (Traversable t, Applicative f) => (a -> f b) -> t a -> f (t b)
sequenceA :: (Traversable t, Applicative f) => t (f a) -> f (t a)

function :: [ Big Bool String String ]
function = sequenceA (Big True "String" "String")

fmap (Big True) (id "String") <*> (id "String")

[
    Big True 'S' 'S',
    Big True 'S' 't',
    Big True 'S' 'r',
    Big True 'S' 'i',
    Big True 'S' 'n',
    Big True 'S' 'g',
    
    Big True 't' 'S',
    Big True 't' 't',
    Big True 't' 'r',
    Big True 't' 'i',
    Big True 't' 'n',
    Big True 't' 'g',
    
    Big True 'i' 'S',
    Big True 'i' 't',
    Big True 'i' 'r',
    Big True 'i' 'i',
    Big True 'i' 'n',
    Big True 'i' 'g',
    
    Big True 'n' 'S',
    Big True 'n' 't',
    Big True 'n' 'r',
    Big True 'n' 'i',
    Big True 'n' 'n',
    Big True 'n' 'g',
    
    Big True 'g' 'S',
    Big True 'g' 't',
    Big True 'g' 'r',
    Big True 'g' 'i',
    Big True 'g' 'n',
    Big True 'g' 'g']
```
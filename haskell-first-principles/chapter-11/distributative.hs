module Distributative where


-- type AuthorName = String

-- data Fiction = Fantasy deriving Show
-- data Nonfiction = Facts deriving Show

-- data BookType = FictionBook Fiction | NonfictionBook Nonfiction deriving Show

-- data Author = Fiction AuthorName | Nonfiction AuthorName deriving (Eq, Show)

-- How does your garden grow?
-- what is the sum of products for this type here hmmmm?

-- data FlowerType = Gardenia | Daisy | Rose | Lilac deriving Show

-- Distribute the data to make the types normal form, pull them apart and find the patterns.
type Gardener = String

data Garden = Gardenia Gardener | Daisy Gardener | Rose Gardener | Lilac Gardener   deriving Show


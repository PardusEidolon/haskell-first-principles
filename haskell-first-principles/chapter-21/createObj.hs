module CreateObj where

import Control.Monad

data Query = Query deriving Show
data SomeObj = SomeObj deriving Show
data IoOnlyObj = IoOnlyObj deriving Show
data Err = Err deriving Show

decodeFn :: String -> Either Err SomeObj
decodeFn xs = undefined

fetchFn :: Query -> IO [String]
fetchFn qs = undefined

mkIoOnlyObj :: [SomeObj] -> IO [(SomeObj, IoOnlyObj)]
mkIoOnlyObj ls = undefined

pipelineFn :: Query -> IO (Either Err [(SomeObj, IoOnlyObj)]) 
pipelineFn query = do 
    a <- fetchFn query -- a :: [String]
    case sequence (map decodeFn a) of -- Right [SomeObj] or Left Error
        (Left err) -> return $ Left $ err 
        (Right res) -> do 
            a <- mkIoOnlyObj res -- res :: [SomeObj] -> [(SomeObj, IoOnlyObj)]
            return $ Right a -- this line here returns the type of :: IO (Either Err [(SomeObj, IoOnlyObj)])

-- traverse :: (Traversable t, Applicative f) => (a -> f b) -> t a -> f (t b)
-- mapM :: (Traversable t, Monad m) => (a -> m b) -> t a -> m (t b)

pipelineFn' :: Query -> IO (Either Err [(SomeObj, IoOnlyObj)]) 
pipelineFn' query = do 
    a <- fetchFn query
    traverse mkIoOnlyObj $ mapM decodeFn a

pipelineM :: Query -> IO (Either Err [(SomeObj, IoOnlyObj)]) 
pipelineM = (traverse mkIoOnlyObj . traverse decodeFn ) <=< fetchFn -- IO [String] -> [String]
             -- a1 ^                 -- a2 ^

-- a2 :: (String -> Either Err [SomeObj]) -> [String] -> Either Err [SomeObj]
-- a1 :: ([SomeObj] -> IO [(SomeObj, IoOnlyObj)]) -> Either Err [SomeObj] -> IO ( Either Err [(SomeObj, IoOnlyObj)] )
--          a       ->  f  b                      -> t      a             -> f  (   t           a                   )
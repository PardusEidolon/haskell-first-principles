{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_CoArbitrary (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\CoArbitrary\\.stack-work\\install\\15430940\\bin"
libdir     = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\CoArbitrary\\.stack-work\\install\\15430940\\lib\\x86_64-windows-ghc-8.10.7\\CoArbitrary-0.1.0.0-JLOwXPr8wDQ6Ks1nBuSDal"
dynlibdir  = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\CoArbitrary\\.stack-work\\install\\15430940\\lib\\x86_64-windows-ghc-8.10.7"
datadir    = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\CoArbitrary\\.stack-work\\install\\15430940\\share\\x86_64-windows-ghc-8.10.7\\CoArbitrary-0.1.0.0"
libexecdir = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\CoArbitrary\\.stack-work\\install\\15430940\\libexec\\x86_64-windows-ghc-8.10.7\\CoArbitrary-0.1.0.0"
sysconfdir = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\CoArbitrary\\.stack-work\\install\\15430940\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "CoArbitrary_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "CoArbitrary_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "CoArbitrary_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "CoArbitrary_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "CoArbitrary_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "CoArbitrary_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)

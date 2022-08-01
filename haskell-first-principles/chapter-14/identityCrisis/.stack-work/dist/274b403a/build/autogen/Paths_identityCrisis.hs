{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_identityCrisis (
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

bindir     = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\identityCrisis\\.stack-work\\install\\4316e623\\bin"
libdir     = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\identityCrisis\\.stack-work\\install\\4316e623\\lib\\x86_64-windows-ghc-8.10.7\\identityCrisis-0.1.0.0-LJJPg4mxp9YJrnizXmGAV8"
dynlibdir  = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\identityCrisis\\.stack-work\\install\\4316e623\\lib\\x86_64-windows-ghc-8.10.7"
datadir    = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\identityCrisis\\.stack-work\\install\\4316e623\\share\\x86_64-windows-ghc-8.10.7\\identityCrisis-0.1.0.0"
libexecdir = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\identityCrisis\\.stack-work\\install\\4316e623\\libexec\\x86_64-windows-ghc-8.10.7\\identityCrisis-0.1.0.0"
sysconfdir = "E:\\work\\Haskell\\Haskell-Sandbox\\haskell-first-principles\\chapter-14\\identityCrisis\\.stack-work\\install\\4316e623\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "identityCrisis_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "identityCrisis_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "identityCrisis_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "identityCrisis_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "identityCrisis_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "identityCrisis_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)

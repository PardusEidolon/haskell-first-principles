{pkgs ? import <nixpkgs> {} }:
 pkgs.stdenv.mkDerivation {
    name = "Haskell-First-Principles";
    buidinputs = with pkgs; [
            haskell.compiler.ghc8107
            haskellPackages.stack
            haskellPackages.cabal-install
            haskellPackages.haskell-language-server 
            ];
 }
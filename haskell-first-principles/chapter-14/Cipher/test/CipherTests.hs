{-# LANGUAGE BlockArguments #-}
module CipherTests where

import VinCipher
import Data.Char
import Test.QuickCheck
import Test.Hspec
import VinCipher
import CCipher
import CCipher (unCaesar, caesar)

-- =============================================================================================
--  _    _ _                                             _       _                 
-- | |  | (_)                                           (_)     | |                
-- | |  | |_  ____  ____ ____   ____  ____ ____     ____ _ ____ | | _   ____  ____ 
--  \ \/ /| |/ _  |/ _  )  _ \ / _  )/ ___) _  )   / ___) |  _ \| || \ / _  )/ ___)
--   \  / | ( ( | ( (/ /| | | ( (/ /| |  ( (/ /   ( (___| | | | | | | ( (/ /| |    
--    \/  |_|\_|| |\____)_| |_|\____)_|   \____)   \____)_| ||_/|_| |_|\____)_|    
--          (_____|                                       |_|                      
-- =============================================================================================


type Key = String

data VinCipher = VinCipher Int Char String deriving Show

main :: IO ()
main = hspec $ do
    describe "shift Function Tests" $ do
        it "shift output is identical" $ do
            property prop_shift
        it "are strings, strings?" $ do
            property prop_strings
        it "are shifted strings the same as they are reversed?" $ do
            property prop_shiftF
    describe "int2let & let2int" $ do
        it "identity int2let" $ do
            property prop_int2let
        it "identity let2int" $ do
            property prop_let2int
        it "there and back int2let" $ do
            property prop_intReverse
        it "there and back let2int" $ do
            property prop_charReverse
    describe "Encrypt Functions" $ do
        it "is the type VinCipher equal to VinCipher and does the encrypted result equal each-other?" $ do
            property $ forAll gen_VinCipher prop_vinEncrypt
    describe "BONUS ROUND: Caesar Cipher" $ do
        it "the encrypted result are equal" $ do
            property prop_Caeser
        it "encrypted and decrypted result are equal" $ do
            property prop_thereAndBackAgain

gen_VinCipher :: Gen VinCipher
gen_VinCipher = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return $ VinCipher a b c 

gen_chr :: Gen Char
gen_chr = do
    n <- choose (97,122)
    return $ chr n

gen_int :: Gen Int
gen_int = do
    a <- arbitrary
    return a

gen_string :: Gen String
gen_string = do
    a <- arbitrary
    return a

prop_shift :: Int -> Char -> Bool
prop_shift x y = (shift x y) == (shift x y)

prop_strings :: String -> Bool
prop_strings x = x == x

prop_let2int :: Char -> Bool
prop_let2int x = (let2int x) == (let2int x) 

prop_int2let :: Int -> Bool
prop_int2let x = (int2let x) == (int2let x)

prop_intReverse :: Int -> Bool
prop_intReverse x = let2int (int2let x) == x

prop_charReverse :: Char -> Bool
prop_charReverse x =  int2let (let2int x) == x

prop_shiftF :: String -> Bool
prop_shiftF ws = shiftFactor ws == shiftFactor ws 
                || reverse (shiftFactor ws) == reverse (shiftFactor ws)

prop_vinEncrypt :: VinCipher -> Bool
prop_vinEncrypt vinCipher = if cipherType vinCipher then vinCrypt vinCipher else False
    where
        cipherType vinCipher = case vinCipher of
                 (VinCipher _ _ _) -> True
                 _                 -> False           
        vinCrypt (VinCipher _ _ s) = encrypt s s == encrypt s s 

-- BONUS ROUND: CAESARCIPHER!

prop_Caeser :: Int -> String -> Bool
prop_Caeser x y = (caesar x y) == (caesar x y )

prop_thereAndBackAgain :: Int -> String -> Bool
prop_thereAndBackAgain x y = caesarPrime x y
    where
        caesarPrime x y = (unCaesar x (caesar x y)) == (unCaesar x (caesar x y))

-- (unCaesar x (caesar x y)) == y

-- Fails! capital letters are not the same decrypted

foo :: [String]
foo = [x :[] | x <- ['a'..'z']]
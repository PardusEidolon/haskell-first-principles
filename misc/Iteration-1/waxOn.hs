module Waxon where

waxOn = x * 5
  where x = y ^ 2
        z = 7
        y = z + 8

tripple x = x * 3

waxOff x = tripple x `div` 10
module Where where

multi1     = x * y
   where x = 5
         y = 6

oneThousand   = x * 3 + y
          where x = 3
                y = 1000

timeFive = x * 5
     where x = 10 * 5 + y
           y = 10
negateSeven = z `div` x + y
        where x = 7
              y = negate x
              z = y * 10
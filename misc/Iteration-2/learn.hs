module Learn where

x = 10 * 5 + y

y = 10

myResult = x * 5 

main = x * 3 + y
    where x = 3
          y = 1000

mainTwo = x * 5
    where x = 10 * 5 + y
          y = 10

mainThree = z / x + y
    where x = 7
          y = negate x
          z = y * 10
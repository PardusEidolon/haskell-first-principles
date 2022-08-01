module VehicleTypes where

data Airline = 
                 Boeing 
               | United 
               | Virgin 
               deriving (Eq,Bounded, Show)

newtype Price = Price Int deriving (Eq,Show)

data Size = 
              XtraLarge 
            | Large 
            | Medium 
            | Small 
            deriving (Eq, Show)

data Manufacturer = 
                    Mini 
                  | BMW 
                  | Aston 
                  deriving (Eq,Show)

data Vehicle = 
               Car Manufacturer Price Size 
             | Plane Airline Price Size 
               deriving (Eq,Show)
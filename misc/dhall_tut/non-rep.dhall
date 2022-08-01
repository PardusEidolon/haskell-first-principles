let name1 = "alice"

let name2 = "bob"

let name3 = "carrol"

let name4 = "eve"

let name5 = "frank"

let name6 = "john"

let record1 = { namey = name2, nmubery = 123 }

let record2 = { haggis = name6, bool = False }

in  { administrativeUsers = [ name1, name2, name3 ]
    , ordinaryUser = [ name1, name2, name3, name4, name5, name6 ]
    , bool = True
    , number = 123
    , pie = record1 /\ record2
    , greeting = "hola senor"
    }

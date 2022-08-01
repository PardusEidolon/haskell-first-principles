let Package = 
        <
            URL : {link : Text, Value : Natural}
        |   Person : {Job : Text , Name : Text , Age : Natural}
        |   Identity : {Composable : Bool, Summary : Text}
        >
let pack = Package.URL {link = "www.google.com", Value = 1}
let person = Package.Person {Job = "Man-scaper", Name = "bob" , Age = 13}

in 
    [
        pack
      , person
    ]
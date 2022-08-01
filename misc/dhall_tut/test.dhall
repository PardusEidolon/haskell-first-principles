let job = { department = "Data Platform", title = "Software Engineer" }

let john = { name = "John Doe", position = job }

let alice = { name = "Alice Smith", position = job }

let smallShirt = \(company : Text) -> { company, size = "Large", name = "bob" }

in  [ smallShirt "mache", smallShirt "igor" ]

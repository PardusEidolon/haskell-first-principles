foobindSequel = \r -> bar (foo r) r

foobind m k r = k (m r) r

foo = map (+1)

bar t x = (t,length x)

f = foobind foo bar

fooDo = do
    f <- foo
    b <- bar
    return (b f)

funA = bar <*> foo
funM = f >>= return
{:ok, pid} = GenServer.start_link(Rockelivery.Stack, [:hello])

# Call is syncronous
GenServer.cast(pid, {:push, :world})
GenServer.cast(pid, :pop)

# Cast is asyncronous
GenServer.call(pid, {:push, :world})
GenServer.call(pid, :pop)

{:ok, pid} = Rockelivery.Stack.start_link()
Rockelivery.Stack.push(pid, :world)
Rockelivery.Stack.push_async(pid, :world)
Rockelivery.Stack.pop(pid)
Rockelivery.Stack.pop_async(pid)

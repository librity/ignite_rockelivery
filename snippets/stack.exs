{:ok, pid} = GenServer.start_link(Rockelivery.Stack, [:hello])

# Call is syncronous
GenServer.cast(pid, {:push, :world})
GenServer.cast(pid, :pop)

# Cast is asyncronous
GenServer.call(pid, {:push, :world})
GenServer.call(pid, :pop)

defmodule Rockelivery.Stack do
  use GenServer

  # Client

  def start_link(initial_stack \\ []) when is_list(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack)
  end

  def push(pid, element), do: GenServer.call(pid, {:push, element})

  def push_async(pid, element), do: GenServer.cast(pid, {:push, element})

  def pop(pid), do: GenServer.call(pid, :pop)

  def pop_async(pid), do: GenServer.cast(pid, :pop)

  # Server

  @impl true
  def init(stack), do: {:ok, stack}

  @impl true
  def handle_call({:push, element}, _from, old_stack) do
    new_stack = [element | old_stack]

    {:reply, new_stack, new_stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tails]), do: {:reply, head, tails}
  @impl true
  def handle_call(:pop, _from, []), do: {:reply, nil, []}

  @impl true
  def handle_cast({:push, element}, old_stack), do: {:noreply, [element | old_stack]}
  @impl true
  def handle_cast(:pop, [_head | tails]), do: {:noreply, tails}
  @impl true
  def handle_cast(:pop, []), do: {:noreply, []}
end

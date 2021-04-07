defmodule Rockelivery.Stack do
  use GenServer

  @impl true
  def init(stack \\ []), do: {:ok, stack}

  @impl true
  def handle_call({:push, element}, _from, old_stack) do
    new_stack = [element | old_stack]

    {:reply, new_stack, new_stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tails]), do: {:reply, head, tails}
  def handle_call(:pop, _from, []), do: {:reply, nil, []}

  @impl true
  def handle_cast({:push, element}, old_stack), do: {:noreply, [element | old_stack]}
  def handle_cast(:pop, [_head | tails]), do: {:noreply, tails}
  def handle_cast(:pop, []), do: {:noreply, []}
end

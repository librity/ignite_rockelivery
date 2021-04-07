defmodule Rockelivery.Orders.Total do
  alias Rockelivery.Item

  def calculate([%Item{} | _tails] = items) do
    items
    |> Enum.reduce(Decimal.new("0.00"), &accumulate_total/2)
  end

  defp accumulate_total(%Item{price: price}, accumulator), do: Decimal.add(accumulator, price)
end

defmodule Rockelivery.Orders.ValidateAndMultiplyItems do
  alias Rockelivery.Error

  def call(items, item_ids, items_params) do
    items_by_id = Map.new(items, fn item -> {item.id, item} end)

    item_ids
    |> Stream.map(fn id -> {id, Map.get(items_by_id, id)} end)
    |> Enum.any?(fn {_id, item_or_nil} -> is_nil(item_or_nil) end)
    |> multiply_items(items_by_id, items_params)
  end

  defp multiply_items(true, _items_by_id, _items_params),
    do: {:error, Error.build_item_not_found_error()}

  defp multiply_items(false, items_by_id, items_params) do
    multiplied_items = Enum.reduce(items_params, [], &multiply_item(items_by_id, &1, &2))

    {:ok, multiplied_items}
  end

  defp multiply_item(items_by_id, %{"id" => id, "quantity" => quantity}, accumulator) do
    item = Map.get(items_by_id, id)
    accumulator ++ List.duplicate(item, quantity)
  end
end

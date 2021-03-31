defmodule Rockelivery.Orders.Create do
  import Ecto.Query

  alias Rockelivery.{Error, Order, Item, Repo}

  def call(params) do
    params
    |> handle_items()
  end

  defp handle_items(%{"items" => items_params}) do
    item_ids = Enum.map(items_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^item_ids

    query
    |> Repo.all()
    |> validate_and_multiply_items(item_ids, items_params)
  end

  defp validate_and_multiply_items(items, item_ids, items_params) do
    items_by_id = Map.new(items, fn item -> {item.id, item} end)

    item_ids
    |> Stream.map(fn id -> {id, Map.get(items_by_id, id)} end)
    |> Enum.any?(fn {_id, item_or_nil} -> is_nil(item_or_nil) end)
    |> multiply_items(items_by_id, items_params)
  end

  defp multiply_items(true, _items_by_id, _items_params),
    do: {:error, Error.build_item_not_found_error()}

  defp multiply_items(false, items_by_id, items_params) do
    Enum.reduce(items_params, [], &multiply_item(items_by_id, &1, &2))
  end

  defp multiply_item(items_by_id, %{"id" => id, "quantity" => quantity}, accumulator) do
    item = Map.get(items_by_id, id)
    accumulator ++ List.duplicate(item, quantity)
  end
end

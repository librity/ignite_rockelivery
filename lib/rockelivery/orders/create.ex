defmodule Rockelivery.Orders.Create do
  import Ecto.Query

  alias Rockelivery.{Error, Item, Order, Repo}
  alias Rockelivery.Orders.ValidateAndMultiplyItems

  def call(params) do
    params
    |> fetch_items()
    |> handle_items(params)
  end

  defp fetch_items(%{"items" => items_params}) do
    item_ids = Enum.map(items_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^item_ids

    query
    |> Repo.all()
    |> ValidateAndMultiplyItems.call(item_ids, items_params)
  end

  defp handle_items({:error, _error} = result, _params), do: result

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:error, reason}), do: {:error, Error.build(:bad_request, reason)}
  defp handle_insert({:ok, %Order{}} = result), do: result
end

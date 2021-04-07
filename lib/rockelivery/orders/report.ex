defmodule Rockelivery.Orders.Report do
  import Ecto.Query

  alias Rockelivery.{Repo, Order, Item}

  @batch_size 500

  def create(filename \\ "report") do
    Repo.transaction(&fetch_orders/0)
  end

  defp fetch_orders() do
    query = from order in Order, order_by: order.user_id

    query
    |> Repo.stream(max_rows: @batch_size)
    |> Stream.chunk_every(@batch_size)
    |> Stream.flat_map(fn chunk -> Repo.preload(chunk, :items) end)
    |> Enum.map(&stringify_order/1)
  end

  defp stringify_order(%Order{user_id: user_id, payment_method: payment_method, items: items}) do
    items_string = Enum.map(items, &stringify_item/1)
    total_price = "50.0"

    "#{user_id},#{payment_method},#{items_string}#{total_price}\n"
  end

  defp stringify_item(%Item{category: category, description: description, price: price}) do
    "#{category},#{description},#{price},"
  end
end

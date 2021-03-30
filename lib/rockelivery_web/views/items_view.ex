defmodule RockeliveryWeb.ItemsView do
  use RockeliveryWeb, :view

  alias Rockelivery.Item

  def render("items.json", %{items: [%Item{} | _tails] = items}), do: %{items: items}

  def render("item.json", %{item: %Item{} = item}), do: %{item: item}

  def render("create.json", %{item: %Item{} = item}) do
    %{message: "Item created successfully", item: item}
  end
end

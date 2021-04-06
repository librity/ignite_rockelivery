defmodule RockeliveryWeb.ItemsViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias Rockelivery.Item
  alias RockeliveryWeb.ItemsView

  test "renders create.json" do
    item = build(:item)

    return = render(ItemsView, "create.json", item: item)

    assert %{
             message: "Item created successfully",
             item: %Item{
               category: :food,
               description: "Bananas",
               id: nil,
               inserted_at: nil,
               photo: "/static/items/bananas.png",
               price: Decimal.new("12.50"),
               updated_at: nil
             }
           } == return
  end
end

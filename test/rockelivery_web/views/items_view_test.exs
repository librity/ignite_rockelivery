defmodule RockeliveryWeb.ItemsViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.ItemsView

  test "renders create.json" do
    item = build(:item)

    return = render(ItemsView, "create.json", item: item)

    assert %{
             message: "Item created successfully",
             item: %Rockelivery.Item{
               category: :food,
               description: "Bananas",
               photo: "/static/items/bananas.png"
             }
           } = return
  end
end

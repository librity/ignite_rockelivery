defmodule RockeliveryWeb.OrdersView do
  use RockeliveryWeb, :view

  alias Rockelivery.Order

  def render("create.json", %{order: %Order{} = order}) do
    %{message: "Order created successfully", order: order}
  end
end

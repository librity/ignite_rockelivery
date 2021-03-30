# Create an item
item_params = %{
  category: :food,
  description: "Bananas",
  price: Decimal.new("12.50"),
  photo: "/static/items/bananas.png"
}
Rockelivery.Items.Create.call(item_params)

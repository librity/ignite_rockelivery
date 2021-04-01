# Create an item
item_params = %{
  category: :food,
  description: "Bananas",
  price: Decimal.new("12.50"),
  photo: "/static/items/bananas.png"
}
Rockelivery.Items.Create.call(item_params)

# Item queries
Rockelivery.Repo.all(Rockelivery.Item)
import Ecto.Query
item_ids = [
  "f8658870-8135-467f-842a-ebfa35d30341",
  "f8658870-8135-467f-842a-ebfa35d30341",
  "5ca56e6b-df52-4647-b838-e99b53ea63df",
  "5ca56e6b-df52-4647-b838-e99b53ea63df",
  "5ca56e6b-df52-4647-b838-e99b53ea63df"
]
query = from item in Rockelivery.Item, where: item.id in ^item_ids
Rockelivery.Repo.all(query)

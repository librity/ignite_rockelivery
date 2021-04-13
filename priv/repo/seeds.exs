# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rockelivery.{Item, User}

user_params = %{
  "name" => "Luisito",
  "age" => 40,
  "email" => "luisito@example.com",
  "cpf" => "12345678910",
  "address" => "paper street 123",
  "cep" => "01001000",
  "password" => "password"
}

{:ok, %User{id: user_id}} = Rockelivery.Users.Create.call(user_params)

item_params = %{
  category: :food,
  description: "Bananas",
  price: Decimal.new("12.50"),
  photo: "/static/items/bananas.png"
}

{:ok, %Item{id: item_id}} = Rockelivery.Items.Create.call(item_params)

order_params = %{
  "user_id" => user_id,
  "items" => [
    %{
      "id" => item_id,
      "quantity" => 2
    }
  ],
  "address" => "Paper Street 123",
  "comments" => "Project mayhem brunch",
  "payment_method" => "cash"
}

Rockelivery.Orders.Create.call(order_params)

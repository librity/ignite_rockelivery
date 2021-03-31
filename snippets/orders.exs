# Create order w/ items
order_params = %{
  "items" => [
    %{
      "id" => "f8658870-8135-467f-842a-ebfa35d30341",
      "quantity" => 2
    },
    %{
      "id" => "5ca56e6b-df52-4647-b838-e99b53ea63df",
      "quantity" => 3
    }
  ]
}
Rockelivery.Orders.Create.call(order_params)

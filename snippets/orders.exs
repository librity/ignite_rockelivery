# Create order w/ items
order_params = %{
  "user_id" => "9aa053b9-a799-4295-b023-141f3d1560be",
  "items" => [
    %{
      "id" => "00c0df1c-cd43-4b6f-abe5-ac98de2f446f",
      "quantity" => 2
    }
  ],
  "address" => "Paper Street 123",
	"comments" => "Project mayhem brunch",
	"payment_method" => "cash"
}
Rockelivery.Orders.Create.call(order_params)

# Bad Items
bad_params = %{
  "items" => [
    %{
      "id" => "f8658870-8135-467f-842a-ebfa35d30345",
      "quantity" => 2
    }
  ]
}
Rockelivery.Orders.Create.call(bad_params)

# Bad User
bad_params = %{
  "user_id" => "9aa053b9-a799-4295-b023-141f3d1560b3",
  "items" => [
    %{
      "id" => "00c0df1c-cd43-4b6f-abe5-ac98de2f446f",
      "quantity" => 2
    }
  ],
  "address" => "Paper Street 123",
	"comments" => "Project mayhem brunch",
	"payment_method" => "cash"
}
Rockelivery.Orders.Create.call(bad_params)

# Bad Order
bad_params = %{
  "user_id" => "9aa053b9-a799-4295-b023-141f3d1560be",
  "items" => [
    %{
      "id" => "00c0df1c-cd43-4b6f-abe5-ac98de2f446f",
      "quantity" => 2
    }
  ],
  "address" => "bad",
	"comments" => "bad",
	"payment_method" => "bad"
}
Rockelivery.Orders.Create.call(bad_params)

# Get orders:
Rockelivery.Repo.all(Rockelivery.Order)

# Report:
Enum.chunk_every([1, 2, 3, 4, 5, 6, 7, 8], 3) |> Enum.flat_map(fn [_head | tails] -> tails end)
Rockelivery.Orders.Report.create()

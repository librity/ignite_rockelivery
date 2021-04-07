Enum.chunk_every([1, 2, 3, 4, 5, 6, 7, 8], 3) |> Enum.flat_map(fn [_head | tails] -> tails end)

Rockelivery.Orders.Report.create()

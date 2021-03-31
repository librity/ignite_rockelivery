defmodule Rockelivery.Repo.Migrations.CreatePaymentMethods do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE payment_method AS ENUM ('cash', 'credit', 'debit')"
    down_query = "DROP TYPE payment_method"

    execute(up_query, down_query)
  end
end

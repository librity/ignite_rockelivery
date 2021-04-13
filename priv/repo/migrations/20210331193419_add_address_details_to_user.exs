defmodule Rockelivery.Repo.Migrations.AddAddressDetailsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :city, :string
      add :state, :string
      add :neighborhood, :string
      add :street, :string
    end
  end
end

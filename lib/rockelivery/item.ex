defmodule Rockelivery.Item do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Enum
  alias Rockelivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:category, :description, :price, :photo]
  @categories [:food, :drink, :desert]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "items" do
    field :category, Enum, values: @categories
    field :description, :string
    field :price, :decimal
    field :photo, :string

    many_to_many :orders, Order, join_through: "order_items"

    timestamps()
  end

  def changeset(item \\ %__MODULE__{}, params) do
    item
    |> cast(params, @required_params)
    |> validate_changeset()
  end

  defp validate_changeset(changeset) do
    changeset
    |> validate_required(@required_params)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than: 0)
  end
end

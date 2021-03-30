defmodule Rockelivery.Item do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Enum

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:category, :description, :price, :photo]
  @valid_categories [:food, :drink, :desert]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "items" do
    field :category, Enum, values: @valid_categories
    field :description, :string
    field :price, :decimal
    field :photo, :string

    timestamps()
  end

  def changeset(item \\ %__MODULE__{}, params) do
    item
    |> cast(params, @required_params)
    |> validate_changeset(@required_params)
  end

  defp validate_changeset(changeset, required_params) do
    changeset
    |> validate_required(required_params)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than: 0)
  end
end

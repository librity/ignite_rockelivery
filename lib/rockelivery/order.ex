defmodule Rockelivery.Order do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Enum
  alias Rockelivery.{Item, User}

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:address, :comments, :payment_method, :user_id]
  @payment_methods [:cash, :credit, :debit]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "orders" do
    field :address, :string
    field :comments, :string
    field :payment_method, Enum, values: @payment_methods

    many_to_many :items, Item, join_through: "order_items"
    belongs_to :user, User

    timestamps()
  end

  def changeset(order \\ %__MODULE__{}, params, items) do
    order
    |> cast(params, @required_params)
    |> put_assoc(:items, items)
    |> validate_changeset()
  end

  defp validate_changeset(changeset) do
    changeset
    |> validate_required(@required_params)
    |> validate_length(:address, min: 10)
    |> validate_length(:comments, min: 6)
  end
end

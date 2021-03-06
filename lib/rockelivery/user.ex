defmodule Rockelivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rockelivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:name, :age, :email, :cpf, :cep, :address, :password]
  @update_required_params @required_params -- [:password]
  @optional_params [:city, :state, :neighborhood, :street]
  @params @required_params ++ @optional_params

  @derive {Jason.Encoder, only: [:id, :age, :cpf, :address, :email]}

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :cpf, :string

    field :cep, :string
    field :city, :string
    field :state, :string
    field :neighborhood, :string
    field :street, :string
    field :address, :string

    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :orders, Order

    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:create)
  end

  def build(user, params) do
    user
    |> changeset(params)
    |> apply_action(:create)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @params)
    |> validate_changeset(@required_params)
    |> validate_constraints()
    |> generate_password_hash()
  end

  def changeset(user, new_params) do
    user
    |> cast(new_params, @params)
    |> validate_changeset(@update_required_params)
    |> validate_constraints()
    |> generate_password_hash()
  end

  defp validate_changeset(changeset, required_params) do
    changeset
    |> validate_required(required_params)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
  end

  defp validate_constraints(changeset) do
    changeset
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
  end

  defp generate_password_hash(
         %Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    changeset
    |> change(Pbkdf2.add_hash(password))
  end

  defp generate_password_hash(changeset), do: changeset
end

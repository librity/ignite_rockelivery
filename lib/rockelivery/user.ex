defmodule Rockelivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:address, :age, :cep, :cpf, :email, :password, :name]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :cpf, :string

    field :address, :string
    field :cep, :string

    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_changeset()
    |> generate_password_hash()
  end

  defp validate_changeset(changeset) do
    changeset
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
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

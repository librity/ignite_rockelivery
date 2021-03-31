defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.{Item, User}

  def user_params_factory do
    %{
      name: "Tyler Durden",
      age: 40,
      email: "tyler@under.ground",
      cpf: "12345678910",
      address: "Paper street 123",
      cep: "01001000",
      password: "first_rule"
    }
  end

  def user_json_factory do
    build(:user_params)
    |> stringify_map()
  end

  def bad_user_params_factory do
    %{
      name: "Tyler Durden",
      age: 5,
      email: "BAD",
      cpf: "BAD",
      address: "Paper street 123",
      cep: "BAD"
    }
  end

  def bad_user_json_factory do
    build(:bad_user_params)
    |> stringify_map()
  end

  def user_factory do
    %User{
      id: "e173f324-9d91-43a9-a45a-e6647abf721c",
      address: "Paper street 123",
      age: 40,
      cep: "01001000",
      city: "São Paulo",
      cpf: "12345678910",
      name: "Tyler Durden",
      email: "tyler@under.ground",
      neighborhood: "Sé",
      password: "first_rule",
      state: "SP",
      street: "Praça da Sé"
    }
  end

  def item_params_factory do
    %{
      category: :food,
      description: "Bananas",
      price: "12.50",
      photo: "/static/items/bananas.png"
    }
  end

  def item_json_factory do
    build(:item_params)
    |> stringify_map()
  end

  def bad_item_params_factory do
    %{
      category: :nunchucks,
      description: "123",
      price: "0.0",
      photo: 123
    }
  end

  def bad_item_json_factory do
    build(:bad_item_params)
    |> stringify_map()
  end

  def item_factory do
    %Item{
      category: :food,
      description: "Bananas",
      price: Decimal.new("12.50"),
      photo: "/static/items/bananas.png"
    }
  end

  defp stringify_map(map) do
    for {key, val} <- map, into: %{}, do: {Atom.to_string(key), val}
  end
end

defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      name: "Tyler Durden",
      age: 40,
      email: "tyler@under.ground",
      cpf: "12345678910",
      address: "Paper street 123",
      cep: "12345678",
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
      name: "Tyler Durden",
      age: 40,
      email: "tyler@under.ground",
      cpf: "12345678910",
      address: "Paper street 123",
      cep: "12345678",
      password: "first_rule"
    }
  end

  defp stringify_map(map) do
    for {key, val} <- map, into: %{}, do: {Atom.to_string(key), val}
  end
end

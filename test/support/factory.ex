defmodule Rockelivery.Factory do
  use ExMachina

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
end

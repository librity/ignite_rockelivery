defmodule Rockelivery.Factories.User do
  alias Rockelivery.Factories.Utils

  alias Rockelivery.User

  defmacro __using__(_opts) do
    quote do
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
        |> Utils.stringify_map()
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
        |> Utils.stringify_map()
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
    end
  end
end

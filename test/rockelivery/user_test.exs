defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/1" do
    test "returns a new valid changeset when all params are valid" do
      user_params = %{
        name: "Tyler Durden",
        age: 40,
        email: "tyler@under.ground",
        cpf: "12345678910",
        address: "Paper street 123",
        cep: "12345678",
        password: "first_rule"
      }

      return = User.changeset(user_params)

      assert %Changeset{changes: %{name: "Tyler Durden"}, valid?: true} = return
    end

    test "returns an invalid changeset when all params aren't valid" do
      bad_user_params = %{
        name: "Tyler Durden",
        age: 5,
        email: "BAD",
        cpf: "BAD",
        address: "Paper street 123",
        cep: "BAD"
      }

      return =
        bad_user_params
        |> User.changeset()

      expected_errors = %{
        age: ["must be greater than or equal to 18"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        email: ["has invalid format"],
        password: ["can't be blank"]
      }

      assert %Changeset{valid?: false} = return
      assert errors_on(return) == expected_errors
    end
  end

  describe "changeset/2" do
    test "returns a valid changeset when all params are valid" do
      user_params = %{
        name: "Tyler Durden",
        age: 40,
        email: "tyler@under.ground",
        cpf: "12345678910",
        address: "Paper street 123",
        cep: "12345678",
        password: "first_rule"
      }

      new_user_params = %{
        name: "UPDATEDDDDDD",
        age: 30,
        email: "UPDATEDDDDDD@UPDATEDDDDDD.com",
        cpf: "UPDATEDDDDD",
        address: "UPDATEDDDDDD",
        cep: "UPDATEDD"
      }

      return =
        user_params
        |> User.changeset()
        |> User.changeset(new_user_params)

      assert %Changeset{changes: %{name: "UPDATEDDDDDD"}, valid?: true} = return
    end

    test "returns an invalid changeset when all params aren't valid" do
      user_params = %{
        name: "Tyler Durden",
        age: 40,
        email: "tyler@under.ground",
        cpf: "12345678910",
        address: "Paper street 123",
        cep: "12345678",
        password: "first_rule"
      }

      bad_user_params = %{
        name: "Tyler Durden",
        age: 5,
        email: "BAD",
        cpf: "BAD",
        address: "Paper street 123",
        cep: "BAD"
      }

      expected_errors = %{
        age: ["must be greater than or equal to 18"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        email: ["has invalid format"]
      }

      return =
        user_params
        |> User.changeset()
        |> User.changeset(bad_user_params)

      assert %Changeset{valid?: false} = return
      assert errors_on(return) == expected_errors
    end
  end
end

defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Users.Create
  alias Rockelivery.{Error, User}

  describe "call/1" do
    test "return a user when params are valid" do
      user_params = build(:user_params)

      return = Create.call(user_params)

      assert {:ok, %User{id: _id, age: 40, email: "tyler@under.ground"}} = return
    end

    test "return an error when params aren't valid" do
      bad_user_params = build(:bad_user_params)

      return = Create.call(bad_user_params)

      expected_errors = %{
        age: ["must be greater than or equal to 18"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        email: ["has invalid format"],
        password: ["can't be blank"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = return
      assert errors_on(changeset) == expected_errors
    end
  end
end

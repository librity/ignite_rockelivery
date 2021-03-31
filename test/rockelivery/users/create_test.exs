defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Users.Create
  alias Rockelivery.{Error, User}

  describe "call/1" do
    test "return a user if params are valid" do
      user_json = build(:user_json)

      return = Create.call(user_json)

      assert {:ok, %User{id: _id, age: 40, email: "tyler@under.ground"}} = return
    end

    test "return an error if params aren't valid" do
      bad_user_json = build(:bad_user_json)

      return = Create.call(bad_user_json)

      expected_errors = %{
        age: ["must be greater than or equal to 18"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        email: ["has invalid format"],
        password: ["can't be blank"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = return
      assert expected_errors == errors_on(changeset)
    end
  end
end

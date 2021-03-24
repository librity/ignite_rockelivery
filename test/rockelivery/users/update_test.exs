defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Users.Update
  alias Rockelivery.{Error, User}

  describe "call/1" do
    test "return the updated user if params are valid" do
      %User{id: id} = insert(:user)

      user_params = build(:user_json, %{"id" => id, "name" => "UPDATEDDDDD"})

      return = Update.call(user_params)

      assert {:ok, %User{id: _id, name: "UPDATEDDDDD"}} = return
    end

    test "return an error if params aren't valid" do
      %User{id: id} = insert(:user)

      bad_user_params = build(:bad_user_json, %{"id" => id})

      return = Update.call(bad_user_params)

      expected_errors = %{
        age: ["must be greater than or equal to 18"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        email: ["has invalid format"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = return
      assert errors_on(changeset) == expected_errors
    end
  end
end

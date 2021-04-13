defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase, async: true

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Update
  alias ViaCEP.ClientMock

  describe "call/1" do
    test "return the updated user if params are valid" do
      %User{id: id} = insert(:user)

      user_params = build(:user_json, %{"id" => id, "name" => "UPDATEDDDDD"})

      expect(ClientMock, :get_cep_info, fn _cep -> {:ok, build(:cep_info)} end)

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
      assert expected_errors == errors_on(changeset)
    end
  end
end

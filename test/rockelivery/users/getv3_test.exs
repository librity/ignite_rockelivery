defmodule Rockelivery.Users.GetV3Test do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.User
  alias Rockelivery.Users.GetV3

  describe "by_id/1" do
    test "returns the user if it exists" do
      %User{id: id} = insert(:user)

      return = GetV3.by_id(id)

      assert {:ok,
              %Rockelivery.User{
                address: "Paper street 123",
                age: 40,
                cep: "01001000",
                cpf: "12345678910",
                email: "tyler@under.ground",
                id: "e173f324-9d91-43a9-a45a-e6647abf721c",
                name: "Tyler Durden",
                password: nil,
                password_hash: nil
              }} = return
    end

    test "return an error if user doesn't exist" do
      madeup_uuid = "82c6075f-46fa-4644-b489-f822480fab67"

      return = GetV3.by_id(madeup_uuid)

      assert {:error, %{result: "User not found", status: :not_found}} = return
    end

    test "return an error if uuid isn't valid" do
      bad_uuid = "BAD"

      return = GetV3.by_id(bad_uuid)

      assert {:error, %{result: "Invalid UUID", status: :bad_request}} = return
    end
  end
end

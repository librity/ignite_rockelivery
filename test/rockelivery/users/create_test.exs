defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  import Mox
  import Rockelivery.Factory

  alias ViaCEP.ClientMock

  alias Rockelivery.Users.Create
  alias Rockelivery.{Error, User}

  describe "call/1" do
    test "return a user if params are valid" do
      user_json = build(:user_json)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok,
         %{
           "city" => "New York",
           "neighborhood" => "Bed–Stuy",
           "state" => "NY",
           "street" => "Paper Street 123"
         }}
      end)

      return = Create.call(user_json)

      assert {:ok,
              %User{
                id: _id,
                age: 40,
                email: "tyler@under.ground",
                city: "New York",
                neighborhood: "Bed–Stuy",
                state: "NY",
                street: "Paper Street 123"
              }} = return
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

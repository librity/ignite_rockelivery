defmodule RockeliveryWeb.UsersController.CreateTest do
  use RockeliveryWeb.ConnCase, async: true

  import Mox
  import Rockelivery.Factory

  alias ViaCEP.ClientMock

  describe "create/2" do
    test "returns a created user if params are valid", %{conn: conn} do
      user_params = build(:user_json)

      expect(ClientMock, :get_cep_info, fn _cep -> {:ok, build(:cep_info)} end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, user_params))
        |> json_response(:created)

      assert %{
               "message" => "User created successfully",
               "user" => %{
                 "address" => "Paper street 123",
                 "age" => 40,
                 "cpf" => "12345678910",
                 "email" => "tyler@under.ground",
                 "id" => _id
               }
             } = response
    end

    test "returns an error if params aren't valid", %{conn: conn} do
      bad_user_params = build(:bad_user_json)

      response =
        conn
        |> post(Routes.users_path(conn, :create, bad_user_params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "age" => ["must be greater than or equal to 18"],
                 "cep" => ["should be 8 character(s)"],
                 "cpf" => ["should be 11 character(s)"],
                 "email" => ["has invalid format"],
                 "password" => ["can't be blank"]
               }
             } = response
    end
  end
end

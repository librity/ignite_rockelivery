defmodule RockeliveryWeb.UsersController.UpdateTest do
  use RockeliveryWeb.ConnCase, async: true

  import Mox
  import Rockelivery.Factory

  alias ViaCEP.ClientMock
  alias Rockelivery.User

  describe "update/2" do
    test "returns the updated user if params are valid", %{conn: conn} do
      %User{id: id} = insert(:user)

      update_params =
        build(:user_json, %{
          "address" => "UPDATEDDDDD",
          "age" => 100,
          "cpf" => "UPDATEDDDDD",
          "email" => "UPDATEDDDDD@UPDATEDDDDD.UPDATEDDDDD"
        })

      expect(ClientMock, :get_cep_info, fn _cep -> {:ok, build(:cep_info)} end)

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, update_params))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "address" => "UPDATEDDDDD",
                 "age" => 100,
                 "cpf" => "UPDATEDDDDD",
                 "email" => "UPDATEDDDDD@UPDATEDDDDD.UPDATEDDDDD",
                 "id" => "e173f324-9d91-43a9-a45a-e6647abf721c"
               }
             } = response
    end

    test "returns an error if params aren't valid", %{conn: conn} do
      %User{id: id} = insert(:user)

      bad_params = build(:bad_user_json)

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, bad_params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "age" => ["must be greater than or equal to 18"],
                 "cep" => ["should be 8 character(s)"],
                 "cpf" => ["should be 11 character(s)"],
                 "email" => ["has invalid format"]
               }
             } = response
    end

    test "returns an error if user doesn't exit", %{conn: conn} do
      update_params = build(:user_json)
      madeup_uuid = "82c6075f-46fa-4644-b489-f822480fab67"

      response =
        conn
        |> put(Routes.users_path(conn, :update, madeup_uuid, update_params))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} = response
    end

    test "returns an error if uuid isn't valid", %{conn: conn} do
      update_params = build(:user_json)

      response =
        conn
        |> put(Routes.users_path(conn, :update, "BAD", update_params))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid UUID"} = response
    end
  end
end

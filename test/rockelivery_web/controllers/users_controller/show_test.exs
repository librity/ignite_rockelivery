defmodule RockeliveryWeb.UsersController.ShowTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.User
  alias RockeliveryWeb.Auth.Guardian

  describe "show/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "returns the user if params are valid", %{conn: conn, user: user} do
      %User{id: id} = user

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "address" => "Paper street 123",
                 "age" => 40,
                 "cpf" => "12345678910",
                 "email" => "tyler@under.ground",
                 "id" => "e173f324-9d91-43a9-a45a-e6647abf721c"
               }
             } = response
    end

    test "returns an error if user doesn't exist", %{conn: conn} do
      madeup_uuid = "82c6075f-46fa-4644-b489-f822480fab67"

      response =
        conn
        |> get(Routes.users_path(conn, :show, madeup_uuid))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} = response
    end

    test "returns an error if uuid isn't valid", %{conn: conn} do
      response =
        conn
        |> get(Routes.users_path(conn, :show, "BAD"))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid UUID"} = response
    end
  end
end

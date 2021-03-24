defmodule RockeliveryWeb.UsersController.ShowTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.User

  describe "show/2" do
    test "returns the user if params are valid", %{conn: conn} do
      %User{id: id} = insert(:user)

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
      response =
        conn
        |> get(Routes.users_path(conn, :show, "82c6075f-46fa-4644-b489-f822480fab67"))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} = response
    end

    test "returns an error if uuid is invalid", %{conn: conn} do
      response =
        conn
        |> get(Routes.users_path(conn, :show, "BAD"))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid UUID"} = response
    end
  end
end

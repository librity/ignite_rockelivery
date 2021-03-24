defmodule RockeliveryWeb.UsersController.DeleteTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.User

  describe "delete/2" do
    test "deletes the user if it exists", %{conn: conn} do
      %User{id: id} = insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert "" = response
    end

    test "returns an error if user doesn't exist", %{conn: conn} do
      madeup_uuid = "82c6075f-46fa-4644-b489-f822480fab67"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, madeup_uuid))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} = response
    end

    test "returns an error if uuid isn't invalid", %{conn: conn} do
      response =
        conn
        |> delete(Routes.users_path(conn, :delete, "BAD"))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid UUID"} = response
    end
  end
end

defmodule RockeliveryWeb.UsersController.IndexTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  describe "index/2" do
    test "returns a list of all user", %{conn: conn} do
      insert(:user)

      response =
        conn
        |> get(Routes.users_path(conn, :index, %{}))
        |> json_response(:ok)

      assert %{
               "users" => [
                 %{
                   "address" => "Paper street 123",
                   "age" => 40,
                   "cpf" => "12345678910",
                   "email" => "tyler@under.ground",
                   "id" => "e173f324-9d91-43a9-a45a-e6647abf721c"
                 }
               ]
             } = response
    end
  end
end

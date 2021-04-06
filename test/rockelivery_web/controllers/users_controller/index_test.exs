defmodule RockeliveryWeb.UsersController.IndexTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory
  alias RockeliveryWeb.Auth.Guardian

  describe "index/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "returns a list of all user", %{conn: conn} do
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

defmodule RockeliveryWeb.WelcomeControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  describe "index/2" do
    test "returns a welcome message", %{conn: conn} do
      response =
        conn
        |> get(Routes.welcome_path(conn, :index, "123"))
        |> json_response(:ok)

      assert %{"message" => "Welcome to RockeliveryWeb 1.0!"} = response
    end
  end
end

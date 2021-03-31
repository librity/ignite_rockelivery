defmodule RockeliveryWeb.ItemsController.CreateTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  describe "create/2" do
    test "returns a created item if params are valid", %{conn: conn} do
      item_params = build(:item_json)

      response =
        conn
        |> post(Routes.items_path(conn, :create, item_params))
        |> json_response(:created)

      assert %{
               "item" => %{
                 "id" => _id,
                 "category" => "food",
                 "description" => "Bananas",
                 "photo" => "/static/items/bananas.png",
                 "price" => "12.50"
               },
               "message" => "Item created successfully"
             } = response
    end

    test "returns an error if params aren't valid", %{conn: conn} do
      bad_item_params = build(:bad_item_json)

      response =
        conn
        |> post(Routes.items_path(conn, :create, bad_item_params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "category" => ["is invalid"],
                 "description" => ["should be at least 6 character(s)"],
                 "price" => ["must be greater than 0"]
               }
             } = response
    end
  end
end

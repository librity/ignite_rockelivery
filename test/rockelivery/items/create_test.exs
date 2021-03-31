defmodule Rockelivery.Items.CreateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Items.Create
  alias Rockelivery.{Error, Item}

  describe "call/1" do
    test "return a item if params are valid" do
      item_params = build(:item_params)

      return = Create.call(item_params)

      assert {:ok,
              %Item{
                id: _id,
                category: :food,
                description: "Bananas",
                photo: "/static/items/bananas.png"
              }} = return
    end

    test "return an error if params aren't valid" do
      bad_item_params = build(:bad_item_params)

      return = Create.call(bad_item_params)

      expected_errors = %{
        category: ["is invalid"],
        description: ["should be at least 6 character(s)"],
        photo: ["is invalid"],
        price: ["must be greater than 0"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = return
      assert expected_errors == errors_on(changeset)
    end
  end
end

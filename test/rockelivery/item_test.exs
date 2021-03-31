defmodule Rockelivery.ItemTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.Item

  describe "changeset/2" do
    test "returns a new valid changeset if all params are valid" do
      item_params = build(:item_params)

      return = Item.changeset(item_params)

      assert %Changeset{
               changes: %{
                 category: :food,
                 description: "Bananas",
                 photo: "/static/items/bananas.png"
               },
               valid?: true
             } = return
    end

    test "returns a valid changeset if all params are valid" do
      item_params = build(:item_params)

      new_item_params = %{description: "UPDATEDDDDDD"}

      return =
        item_params
        |> Item.changeset()
        |> Item.changeset(new_item_params)

      assert %Changeset{changes: %{description: "UPDATEDDDDDD"}, valid?: true} = return
    end

    test "returns an invalid changeset if params aren't valid" do
      item_params = build(:item_params)

      bad_item_params = build(:bad_item_params)

      expected_errors = %{
        category: ["is invalid"],
        description: ["should be at least 6 character(s)"],
        photo: ["is invalid"],
        price: ["must be greater than 0"]
      }

      return =
        item_params
        |> Item.changeset()
        |> Item.changeset(bad_item_params)

      assert %Changeset{valid?: false} = return
      assert errors_on(return) == expected_errors
    end
  end
end

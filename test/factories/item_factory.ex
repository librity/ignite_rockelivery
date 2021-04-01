defmodule Rockelivery.Factories.Item do
  alias Rockelivery.Factories.Utils

  alias Rockelivery.Item

  defmacro __using__(_opts) do
    quote do
      def item_params_factory do
        %{
          category: :food,
          description: "Bananas",
          price: "12.50",
          photo: "/static/items/bananas.png"
        }
      end

      def item_json_factory do
        build(:item_params)
        |> Utils.stringify_map()
      end

      def bad_item_params_factory do
        %{
          category: :nunchucks,
          description: "123",
          price: "0.0",
          photo: 123
        }
      end

      def bad_item_json_factory do
        build(:bad_item_params)
        |> Utils.stringify_map()
      end

      def item_factory do
        %Item{
          category: :food,
          description: "Bananas",
          price: Decimal.new("12.50"),
          photo: "/static/items/bananas.png"
        }
      end
    end
  end
end

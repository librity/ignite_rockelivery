defmodule Rockelivery.Factories.Order do
  alias Rockelivery.Factories.Utils

  alias Rockelivery.Order

  defmacro __using__(_opts) do
    quote do
      def order_factory do
        %Order{
          address: "Paper Street 123",
          comments: "Project mayhem brunch",
          id: "6b81b01d-495d-472e-be2c-3dfaacce7394",
          inserted_at: ~N[2021-04-06 21:36:32],
          payment_method: :cash,
          updated_at: ~N[2021-04-06 21:36:32],
          user_id: "9aa053b9-a799-4295-b023-141f3d1560be"
        }
      end
    end
  end
end

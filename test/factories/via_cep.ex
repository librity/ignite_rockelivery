defmodule Rockelivery.Factories.ViaCEP do
  defmacro __using__(_opts) do
    quote do
      def cep_info_factory do
        %{
          "city" => "New York",
          "neighborhood" => "Bed–Stuy",
          "state" => "NY",
          "street" => "Paper Street 123"
        }
      end
    end
  end
end

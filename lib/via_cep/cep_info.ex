defmodule ViaCEP.CEPInfo do
  def build(city, state, neighborhood, street),
    do: %{
      "city" => city,
      "state" => state,
      "neighborhood" => neighborhood,
      "street" => street
    }
end

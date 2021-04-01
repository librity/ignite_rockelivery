defmodule Rockelivery.Factories.Utils do
  def stringify_map(map) do
    for {key, val} <- map, into: %{}, do: {Atom.to_string(key), val}
  end
end

defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  use Rockelivery.Factories.{ViaCEP, User, Item, Order}
end

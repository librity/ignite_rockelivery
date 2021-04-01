defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  use Rockelivery.Factories.{User, Item}
end

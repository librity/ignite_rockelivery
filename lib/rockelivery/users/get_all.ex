defmodule Rockelivery.Users.GetAll do
  alias Rockelivery.{User, Repo}

  def call, do: Repo.all(User)
end

defmodule Rockelivery.Users.GetAll do
  alias Rockelivery.{Repo, User}

  def call, do: Repo.all(User)
end

defmodule Rockelivery.Users.Create do
  alias Rockelivery.{User, Repo}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end

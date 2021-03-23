defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, User, Repo}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = success), do: success
  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end

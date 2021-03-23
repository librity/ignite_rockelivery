defmodule Rockelivery.Users.GetV3 do
  alias Ecto.UUID
  alias Rockelivery.{User, Repo}

  def by_id(id) do
    id
    |> UUID.cast()
    |> handle_uuid()
  end

  defp handle_uuid(:error), do: {:error, %{status: :bad_request, result: "Invalid UUID"}}
  defp handle_uuid({:ok, uuid}), do: fetch_by_uuid(uuid)

  defp fetch_by_uuid(uuid) do
    Repo.get(User, uuid)
    |> handle_fetch()
  end

  defp handle_fetch(nil), do: {:error, %{status: :not_found, result: "User not found"}}
  defp handle_fetch(%User{} = user), do: {:ok, user}
end

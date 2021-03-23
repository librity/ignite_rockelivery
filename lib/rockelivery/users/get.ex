defmodule Rockelivery.Users.Get do
  alias Ecto.UUID
  alias Rockelivery.{User, Repo}

  def by_id(id) do
    case UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, result: "Invalid UUID"}}
      {:ok, uuid} -> fetch_by_uuid(uuid)
    end
  end

  defp fetch_by_uuid(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, %{status: :not_found, result: "User not found"}}
      %User{} = user -> {:ok, user}
    end
  end
end

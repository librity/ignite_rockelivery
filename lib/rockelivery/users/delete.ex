defmodule Rockelivery.Users.Delete do
  alias Ecto.UUID
  alias Rockelivery.{User, Repo}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, result: "Invalid UUID"}}
      {:ok, uuid} -> delete_by_uuid(uuid)
    end
  end

  defp delete_by_uuid(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, %{status: :not_found, result: "User not found"}}
      %User{} = user -> Repo.delete(user)
    end
  end
end

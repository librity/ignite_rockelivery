defmodule Rockelivery.Users.Get do
  alias Ecto.UUID
  alias Rockelivery.{Error, User, Repo}

  def by_id(id) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_bad_uuid_error()}
      {:ok, uuid} -> fetch_by_uuid(uuid)
    end
  end

  defp fetch_by_uuid(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = user -> {:ok, user}
    end
  end
end

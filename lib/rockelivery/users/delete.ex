defmodule Rockelivery.Users.Delete do
  alias Ecto.UUID
  alias Rockelivery.{Error, User, Repo}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_bad_uuid_error()}
      {:ok, uuid} -> delete_by_uuid(uuid)
    end
  end

  defp delete_by_uuid(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = user -> Repo.delete(user)
    end
  end
end

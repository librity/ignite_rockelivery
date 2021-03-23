defmodule Rockelivery.Users.Update do
  alias Ecto.UUID
  alias Rockelivery.{Error, User, Repo}

  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_bad_uuid_error()}
      {:ok, _uuid} -> fetch_user(params)
    end
  end

  defp fetch_user(%{"id" => uuid} = params) do
    case Repo.get(User, uuid) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = user -> try_to_update(user, params)
    end
  end

  defp try_to_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end

defmodule Rockelivery.Users.Get do
  alias Rockelivery.{Error, Repo, User}

  def by_id(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = user -> {:ok, user}
    end
  end
end

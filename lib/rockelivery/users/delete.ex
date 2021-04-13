defmodule Rockelivery.Users.Delete do
  alias Rockelivery.{Error, Repo, User}

  def call(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = user -> Repo.delete(user)
    end
  end
end

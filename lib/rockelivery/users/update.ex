defmodule Rockelivery.Users.Update do
  alias Rockelivery.{Error, User, Repo}

  def call(%{"id" => uuid} = params) do
    case Repo.get(User, uuid) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = user -> try_to_update(user, params)
    end
  end

  defp try_to_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %User{}} = success), do: success
  defp handle_update({:error, result}), do: {:error, Error.build(:bad_request, result)}
end

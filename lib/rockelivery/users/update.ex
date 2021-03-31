defmodule Rockelivery.Users.Update do
  alias ViaCEP.Client, as: CEPClient

  alias Rockelivery.{Error, User, Repo}

  def call(%{"id" => uuid, "cep" => cep} = params) do
    with {:ok, %User{} = old_user} <- fetch_user(uuid),
         {:ok, %User{}} <- User.build(old_user, params),
         {:ok, %{} = cep_info} <- CEPClient.get_cep_info(cep),
         {:ok, merged_params} <- merge_cep_info(cep_info, params),
         {:ok, %User{}} = result <- try_to_update(old_user, merged_params) do
      result
    else
      {:error, %Error{}} = error -> error
      {:error, reason} -> {:error, Error.build(:bad_request, reason)}
    end
  end

  def fetch_user(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = user -> {:ok, user}
    end
  end

  defp merge_cep_info(cep_info, params) do
    merged_params =
      cep_info
      |> Map.merge(params)

    {:ok, merged_params}
  end

  defp try_to_update(old_user, params) do
    old_user
    |> User.changeset(params)
    |> Repo.update()
  end
end

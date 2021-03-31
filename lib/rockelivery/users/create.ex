defmodule Rockelivery.Users.Create do
  alias ViaCEP.Client, as: CEPClient

  alias Rockelivery.{Error, User, Repo}

  def call(%{"cep" => cep} = params) do
    with {:ok, %User{}} <- User.build(params),
         {:ok, %{} = cep_info} <- CEPClient.get_cep_info(cep),
         {:ok, merged_params} <- merge_cep_info(cep_info, params),
         {:ok, %User{}} = result <- insert_user(merged_params) do
      result
    else
      {:error, %Error{}} = error -> error
      {:error, reason} -> {:error, Error.build(:bad_request, reason)}
    end
  end

  defp merge_cep_info(cep_info, params) do
    merged_params =
      cep_info
      |> Map.merge(params)

    {:ok, merged_params}
  end

  defp insert_user(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end

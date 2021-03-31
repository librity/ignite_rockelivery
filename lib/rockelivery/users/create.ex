defmodule Rockelivery.Users.Create do
  alias Rockelivery.ViaCEP.Client, as: CEPClient

  alias Rockelivery.{Error, User, Repo}

  def call(%{"cep" => cep} = params) do
    case CEPClient.get_cep_info(cep) do
      {:ok, cep_info} -> merge_cep_info(cep_info, params)
      {:error, _result} = error -> error
    end
  end

  defp merge_cep_info(cep_info, params) do
    Map.merge(params, cep_info)
    |> insert_user()
  end

  defp insert_user(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = success), do: success
  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end

defmodule ViaCEP.Client do
  use Tesla

  alias Tesla.Env, as: Response
  alias Rockelivery.Error
  alias ViaCEP.CEPInfo

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws/"
  plug Tesla.Middleware.JSON

  def get_cep_info(cep) do
    "#{cep}/json"
    |> get()
    |> handle_get()
  end

  defp handle_get({:error, reason}), do: {:error, Error.build(:bad_request, reason)}

  defp handle_get({:ok, %Response{status: 400, body: _body}}),
    do: {:error, Error.build(:bad_request, "Invalid CEP")}

  defp handle_get({:ok, %Response{status: 200, body: %{"erro" => true}}}),
    do: {:error, Error.build_cep_not_found_error()}

  defp handle_get({:ok, %Response{status: 200, body: body}}) do
    %{
      "uf" => state,
      "localidade" => city,
      "bairro" => neighborhood,
      "logradouro" => street
    } = body

    {:ok, CEPInfo.build(city, state, neighborhood, street)}
  end
end

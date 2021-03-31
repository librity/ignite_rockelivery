defmodule ViaCEP.ClientTest do
  use ExUnit.Case, async: true

  alias ViaCEP.Client

  describe "get_cep_info/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "returns CEP info when it is valid", %{bypass: bypass} do
      cep = "01001000"
      body = ~s({
        "cep": "01001-000",
        "logradouro": "Praça da Sé",
        "complemento": "lado ímpar",
        "bairro": "Sé",
        "localidade": "São Paulo",
        "uf": "SP",
        "ibge": "3550308",
        "gia": "1004",
        "ddd": "11",
        "siafi": "7107"
      })
      url = bypass_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{cep}/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = Client.get_cep_info(url, cep)

      expected =
        {:ok,
         %{
           "city" => "São Paulo",
           "neighborhood" => "Sé",
           "state" => "SP",
           "street" => "Praça da Sé"
         }}

      assert expected == response
    end
  end

  defp bypass_url(port), do: "http://localhost:#{port}"
end

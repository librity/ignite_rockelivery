defmodule ViaCEP.ClientTest do
  use ExUnit.Case, async: true

  alias ViaCEP.Client
  alias Plug.Conn
  alias Rockelivery.Error

  describe "get_cep_info/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "returns CEP info if CEP is valid", %{bypass: bypass} do
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
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
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

    test "returns an error if CEP isn't valid", %{bypass: bypass} do
      cep = "123"
      url = bypass_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{cep}/json", fn conn ->
        conn
        |> Conn.resp(400, "")
      end)

      response = Client.get_cep_info(url, cep)

      expected = {:error, %Error{result: "Invalid CEP", status: :bad_request}}
      assert expected == response
    end

    test "returns an error if CEP doesn't exist", %{bypass: bypass} do
      cep = "00000000"
      body = ~s({"erro": true})
      url = bypass_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{cep}/json", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_cep_info(url, cep)

      expected = {:error, %Error{result: "CEP not found", status: :not_found}}
      assert expected == response
    end

    test "returns an error if server is down", %{bypass: bypass} do
      cep = "00000000"
      url = bypass_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_cep_info(url, cep)

      expected = {:error, %Rockelivery.Error{result: :econnrefused, status: :bad_request}}
      assert expected == response
    end
  end

  defp bypass_url(port), do: "http://localhost:#{port}"
end

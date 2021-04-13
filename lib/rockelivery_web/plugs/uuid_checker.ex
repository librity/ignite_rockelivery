defmodule RockeliveryWeb.Plugs.UUIDChecker do
  import Plug.Conn

  alias Ecto.UUID
  alias Plug.Conn

  def init(options), do: options

  def call(%Conn{params: %{"id" => id}} = conn, _options) do
    case UUID.cast(id) do
      :error -> render_error(conn)
      {:ok, _uuid} -> conn
    end
  end

  def call(conn, _options), do: conn

  defp render_error(conn) do
    body = Jason.encode!(%{message: "Invalid UUID"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end

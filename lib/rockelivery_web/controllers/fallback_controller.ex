defmodule RockeliveryWeb.FallbackController do
  use RockeliveryWeb, :controller

  alias RockeliveryWeb.ErrorView

  def call(connection, {:error, result}) do
    connection
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("400.json", result: result)
  end
end

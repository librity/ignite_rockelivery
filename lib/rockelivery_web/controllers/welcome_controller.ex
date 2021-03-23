defmodule RockeliveryWeb.WelcomeController do
  use RockeliveryWeb, :controller

  def index(connection, params) do
    params
    |> IO.inspect(label: "DEBUGGGGGGGG:::::::::::::\n")

    connection
    |> put_status(:ok)
    |> IO.inspect(label: "DEBUGGGGGGGG:::::::::::::\n")
    |> json(%{message: "Welcome to RockeliveryWeb 1.0!"})
  end
end

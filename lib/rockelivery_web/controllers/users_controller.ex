defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller

  alias Rockelivery.User
  alias RockeliveryWeb.FallbackController

  action_fallback FallbackController

  def create(connection, params) do
    with {:ok, %User{} = user} <- Rockelivery.create_user(params) do
      connection
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end

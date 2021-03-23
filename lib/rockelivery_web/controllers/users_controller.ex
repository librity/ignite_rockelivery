defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller

  alias Rockelivery.User

  def create(connection, params) do
    with {:ok, %User{} = user} <- Rockelivery.create_user(params) do
      connection
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end

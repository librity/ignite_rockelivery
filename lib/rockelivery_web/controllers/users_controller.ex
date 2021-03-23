defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller

  alias Rockelivery.User
  alias RockeliveryWeb.FallbackController

  action_fallback FallbackController

  def index(connection, _params) do
    users = Rockelivery.get_users()

    connection
    |> put_status(:ok)
    |> render("users.json", users: users)
  end

  def show(connection, %{"id" => uuid}) do
    with {:ok, %User{} = user} <- Rockelivery.get_user_by_id(uuid) do
      connection
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def create(connection, params) do
    with {:ok, %User{} = user} <- Rockelivery.create_user(params) do
      connection
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def update(connection, params) do
    with {:ok, %User{} = user} <- Rockelivery.update_user(params) do
      connection
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def delete(connection, %{"id" => uuid}) do
    with {:ok, %User{}} <- Rockelivery.delete_user(uuid) do
      connection
      |> put_status(:no_content)
      |> text("")
    end
  end
end

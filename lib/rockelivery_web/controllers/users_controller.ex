defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller

  alias Rockelivery.User
  alias RockeliveryWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def index(conn, _params) do
    users = Rockelivery.get_users()

    conn
    |> put_status(:ok)
    |> render("users.json", users: users)
  end

  def show(conn, %{"id" => uuid}) do
    with {:ok, %User{} = user} <- Rockelivery.get_user_by_id(uuid) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rockelivery.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user, token: token)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Rockelivery.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def delete(conn, %{"id" => uuid}) do
    with {:ok, %User{}} <- Rockelivery.delete_user(uuid) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end

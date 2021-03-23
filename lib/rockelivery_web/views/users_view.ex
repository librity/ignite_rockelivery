defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view

  alias Rockelivery.User

  def render("users.json", %{users: [%User{} | _tails] = users}), do: %{users: users}

  def render("user.json", %{user: %User{} = user}), do: %{user: user}

  def render("create.json", %{user: %User{} = user}) do
    %{message: "User created successfully", user: user}
  end
end

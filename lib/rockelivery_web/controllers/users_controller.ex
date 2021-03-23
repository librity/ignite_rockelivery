defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller

  def create(connection, params) do
    params
    |> Rockelivery.create_user()
  end
end

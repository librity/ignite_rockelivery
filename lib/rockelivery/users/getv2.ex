defmodule Rockelivery.Users.GetV2 do
  alias Ecto.UUID
  alias Rockelivery.{User, Repo}

  def by_id(id) do
    with {:ok, uuid} <- UUID.cast(id),
         %User{} = user <- Repo.get(User, uuid) do
      {:ok, user}
    else
      :error -> {:error, %{status: :bad_request, result: "Invalid UUID"}}
      nil -> {:error, %{status: :not_found, result: "User not found"}}
    end
  end
end

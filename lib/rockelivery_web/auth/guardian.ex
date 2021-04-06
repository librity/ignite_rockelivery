defmodule RockeliveryWeb.Auth.Guardian do
  use Guardian, otp_app: :rockelivery

  alias Rockelivery.User
  alias Rockelivery.Users.Get, as: GetUser

  def subject_for_token(%User{id: user_id}, _claims), do: {:ok, user_id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> GetUser.by_id()
  end
end

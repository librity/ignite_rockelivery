defmodule Rockelivery do
  @moduledoc """
  Rockelivery keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Rockelivery.Items.Create, as: CreateItem

  alias Rockelivery.Users.GetAll, as: GetAllUsers
  alias Rockelivery.Users.Get, as: GetUser
  alias Rockelivery.Users.Create, as: CreateUser
  alias Rockelivery.Users.Update, as: UpdateUser
  alias Rockelivery.Users.Delete, as: DeleteUser

  defdelegate get_users, to: GetAllUsers, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate update_user(params), to: UpdateUser, as: :call
  defdelegate delete_user(id), to: DeleteUser, as: :call

  defdelegate create_item(params), to: CreateItem, as: :call
end

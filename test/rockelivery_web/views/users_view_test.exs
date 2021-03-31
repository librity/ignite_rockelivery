defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders users.json" do
    users = build_list(2, :user)

    return = render(UsersView, "users.json", users: users)

    assert %{
             users: [
               %Rockelivery.User{
                 address: "Paper street 123",
                 age: 40,
                 cep: "01001000",
                 cpf: "12345678910",
                 email: "tyler@under.ground",
                 id: "e173f324-9d91-43a9-a45a-e6647abf721c",
                 inserted_at: nil,
                 name: "Tyler Durden",
                 password: "first_rule",
                 password_hash: nil,
                 updated_at: nil
               },
               %Rockelivery.User{
                 address: "Paper street 123",
                 age: 40,
                 cep: "01001000",
                 cpf: "12345678910",
                 email: "tyler@under.ground",
                 id: "e173f324-9d91-43a9-a45a-e6647abf721c",
                 inserted_at: nil,
                 name: "Tyler Durden",
                 password: "first_rule",
                 password_hash: nil,
                 updated_at: nil
               }
             ]
           } = return
  end

  test "renders user.json" do
    user = build(:user)

    return = render(UsersView, "user.json", user: user)

    assert %{
             user: %Rockelivery.User{
               address: "Paper street 123",
               age: 40,
               cep: "01001000",
               cpf: "12345678910",
               email: "tyler@under.ground",
               id: "e173f324-9d91-43a9-a45a-e6647abf721c",
               inserted_at: nil,
               name: "Tyler Durden",
               password: "first_rule",
               password_hash: nil,
               updated_at: nil
             }
           } = return
  end

  test "renders create.json" do
    user = build(:user)

    return = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created successfully",
             user: %Rockelivery.User{
               address: "Paper street 123",
               age: 40,
               cep: "01001000",
               cpf: "12345678910",
               email: "tyler@under.ground",
               id: "e173f324-9d91-43a9-a45a-e6647abf721c",
               inserted_at: nil,
               name: "Tyler Durden",
               password: "first_rule",
               password_hash: nil,
               updated_at: nil
             }
           } = return
  end
end

defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias Rockelivery.User
  alias RockeliveryWeb.UsersView

  test "renders users.json" do
    users = build_list(2, :user)

    return = render(UsersView, "users.json", users: users)

    assert %{
             users: [
               %User{
                 address: "Paper street 123",
                 age: 40,
                 cep: "01001000",
                 city: "São Paulo",
                 cpf: "12345678910",
                 email: "tyler@under.ground",
                 id: "e173f324-9d91-43a9-a45a-e6647abf721c",
                 inserted_at: nil,
                 name: "Tyler Durden",
                 neighborhood: "Sé",
                 password: "first_rule",
                 password_hash: nil,
                 state: "SP",
                 street: "Praça da Sé",
                 updated_at: nil
               },
               %User{
                 address: "Paper street 123",
                 age: 40,
                 cep: "01001000",
                 city: "São Paulo",
                 cpf: "12345678910",
                 email: "tyler@under.ground",
                 id: "e173f324-9d91-43a9-a45a-e6647abf721c",
                 inserted_at: nil,
                 name: "Tyler Durden",
                 neighborhood: "Sé",
                 password: "first_rule",
                 password_hash: nil,
                 state: "SP",
                 street: "Praça da Sé",
                 updated_at: nil
               }
             ]
           } == return
  end

  test "renders user.json" do
    user = build(:user)

    return = render(UsersView, "user.json", user: user)

    assert %{
             user: %User{
               address: "Paper street 123",
               age: 40,
               cep: "01001000",
               city: "São Paulo",
               cpf: "12345678910",
               email: "tyler@under.ground",
               id: "e173f324-9d91-43a9-a45a-e6647abf721c",
               inserted_at: nil,
               name: "Tyler Durden",
               neighborhood: "Sé",
               password: "first_rule",
               password_hash: nil,
               state: "SP",
               street: "Praça da Sé",
               updated_at: nil
             }
           } == return
  end

  test "renders create.json" do
    user = build(:user)

    return = render(UsersView, "create.json", user: user, token: "token123")

    assert %{
             message: "User created successfully",
             token: "token123",
             user: %User{
               address: "Paper street 123",
               age: 40,
               cep: "01001000",
               city: "São Paulo",
               cpf: "12345678910",
               email: "tyler@under.ground",
               id: "e173f324-9d91-43a9-a45a-e6647abf721c",
               inserted_at: nil,
               name: "Tyler Durden",
               neighborhood: "Sé",
               password: "first_rule",
               password_hash: nil,
               state: "SP",
               street: "Praça da Sé",
               updated_at: nil
             }
           } == return
  end

  test "renders sign_in.json" do
    return = render(UsersView, "sign_in.json", token: "token123")

    assert %{token: "token123"} == return
  end
end

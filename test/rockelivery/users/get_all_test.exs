defmodule Rockelivery.Users.GetAllTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Users.GetAll

  describe "call/1" do
    test "returns a list with all the users" do
      insert(:user)

      return = GetAll.call()

      assert [
               %Rockelivery.User{
                 address: "Paper street 123",
                 age: 40,
                 cep: "12345678",
                 cpf: "12345678910",
                 email: "tyler@under.ground",
                 id: "e173f324-9d91-43a9-a45a-e6647abf721c",
                 name: "Tyler Durden",
                 password: nil,
                 password_hash: nil
               }
             ] = return
    end
  end
end

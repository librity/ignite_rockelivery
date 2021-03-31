defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/1" do
    test "returns a new valid changeset if all params are valid" do
      user_params = build(:user_params)

      return = User.changeset(user_params)

      assert %Changeset{changes: %{name: "Tyler Durden"}, valid?: true} = return
    end

    test "returns an invalid changeset if all params aren't valid" do
      bad_user_params = build(:bad_user_params)

      return =
        bad_user_params
        |> User.changeset()

      expected_errors = %{
        age: ["must be greater than or equal to 18"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        email: ["has invalid format"],
        password: ["can't be blank"]
      }

      assert %Changeset{valid?: false} = return
      assert expected_errors == errors_on(return)
    end
  end

  describe "changeset/2" do
    test "returns a valid changeset if all params are valid" do
      user_params = build(:user_params)

      new_user_params = %{name: "UPDATEDDDDDD"}

      return =
        user_params
        |> User.changeset()
        |> User.changeset(new_user_params)

      assert %Changeset{changes: %{name: "UPDATEDDDDDD"}, valid?: true} = return
    end

    test "returns an invalid changeset if all params aren't valid" do
      user_params = build(:user_params)

      bad_user_params = build(:bad_user_params)

      expected_errors = %{
        age: ["must be greater than or equal to 18"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        email: ["has invalid format"]
      }

      return =
        user_params
        |> User.changeset()
        |> User.changeset(bad_user_params)

      assert %Changeset{valid?: false} = return
      assert expected_errors == errors_on(return)
    end
  end
end

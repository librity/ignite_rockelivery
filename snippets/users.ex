# Create a user
user_params = %{
  "name" => "Luisito",
  "age" => 40,
  "email" => "luisito@example.com",
  "cpf" => "12345678910",
  "address" => "paper street 123",
  "cep" => "01001000",
  "password" => "password"
}
Rockelivery.Users.Create.call(user_params)
bad_params = %{
  "name" => "Luisito",
  "age" => 15,
  "email" => "luisito@example.com",
  "cpf" => "12345678910",
  "address" => "paper street 123",
  "cep" => "01001000",
  "password" => "password"
}
Rockelivery.Users.Create.call(bad_params)

# Fetch users
Rockelivery.Repo.all(Rockelivery.User)
Rockelivery.Repo.get(Rockelivery.User, "a2a60a12-1c03-4357-b370-c78ed28a9e38")

Rockelivery.Users.Get.by_id("a2a60a12-1c03-4357-b370-c78ed28a9e38")
Rockelivery.Users.Get.by_id("8623cdd8-7cad-43cc-953b-c30260a349f8")
Rockelivery.Users.Get.by_id("8623cdd8")

Rockelivery.Users.GetV2.by_id("a2a60a12-1c03-4357-b370-c78ed28a9e38")
Rockelivery.Users.GetV2.by_id("8623cdd8-7cad-43cc-953b-c30260a349f8")
Rockelivery.Users.GetV2.by_id("8623cdd8")

Rockelivery.Users.GetV3.by_id("a2a60a12-1c03-4357-b370-c78ed28a9e38")
Rockelivery.Users.GetV3.by_id("8623cdd8-7cad-43cc-953b-c30260a349f8")
Rockelivery.Users.GetV3.by_id("8623cdd8")

# Update a user
updated_user_params = %{
  "id" => "31a377a0-1800-46ea-ab44-b6a571f9de00",
  "name" => "UPDATEDDDDDD",
  "age" => 40,
  "email" => "UPDATEDDDDDD@UPDATEDDDDD.com",
  "cpf" => "UPDATcDDDDD",
  "address" => "UPDATEDDDDDD",
  "cep" => "18108370"
}
Rockelivery.Users.Update.call(updated_user_params)

# Delete a user
Rockelivery.Users.Delete.call("a2a60a12-1c03-4357-b370-c78ed28a9e38")
Rockelivery.Users.GetV3.by_id("8623cdd8-7cad-43cc-953b-c30260a349f8")
Rockelivery.Users.GetV3.by_id("8623cdd8")

# Verify password:
{:ok, %{password_hash: hash}} = Rockelivery.Users.Get.by_id("a2a60a12-1c03-4357-b370-c78ed28a9e38")
Pbkdf2.verify_pass("password", hash)
Pbkdf2.verify_pass("badddddd", hash)
params = %{
	"id" => "a2a60a12-1c03-4357-b370-c78ed28a9e38",
	"password" => "password"
}
RockeliveryWeb.Auth.Guardian.authenticate(params)
bad_params = %{
	"id" => "a2a60a12-1c03-4357-b370-c78ed28a9e38",
	"password" => "badddddd"
}
RockeliveryWeb.Auth.Guardian.authenticate(bad_params)

# Runs validations and returns User without inserting it in the database
import Ecto.Changeset
user_params = %{
  "address" => "Paper street 123",
  "age" => 40,
  "cep" => "01001000",
  "city" => "São Paulo",
  "cpf" => "12345678910",
  "name" => "Tyler Durden",
  "email" => "tyler@under.ground",
  "neighborhood" => "Sé",
  "password" => "first_rule",
  "state" => "SP",
  "street" => "Praça da Sé"
}
user_params |> Rockelivery.User.changeset() |> apply_action(:create)

bad_params = %{
  "name" => "Luisito",
  "age" => 15,
  "email" => "luisito@example.com",
  "cpf" => "12345678910",
  "address" => "paper street 123",
  "cep" => "01001000",
  "password" => "password"
}
bad_params |> Rockelivery.User.changeset() |> apply_action(:create)

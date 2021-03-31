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
Rockelivery.Repo.get(Rockelivery.User, "8623cdd8-7cad-43cc-953b-c30260a349f4")

Rockelivery.Users.Get.by_id("8623cdd8-7cad-43cc-953b-c30260a349f4")
Rockelivery.Users.Get.by_id("8623cdd8-7cad-43cc-953b-c30260a349f8")
Rockelivery.Users.Get.by_id("8623cdd8")

Rockelivery.Users.GetV2.by_id("8623cdd8-7cad-43cc-953b-c30260a349f4")
Rockelivery.Users.GetV2.by_id("8623cdd8-7cad-43cc-953b-c30260a349f8")
Rockelivery.Users.GetV2.by_id("8623cdd8")

Rockelivery.Users.GetV3.by_id("8623cdd8-7cad-43cc-953b-c30260a349f4")
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
Rockelivery.Users.Delete.call("8623cdd8-7cad-43cc-953b-c30260a349f4")
Rockelivery.Users.GetV3.by_id("8623cdd8-7cad-43cc-953b-c30260a349f8")
Rockelivery.Users.GetV3.by_id("8623cdd8")
